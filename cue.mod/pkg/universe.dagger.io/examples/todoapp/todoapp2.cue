client: {
    filesystem: {
        "./": {
            read: {
                contents: {
                    $dagger: {
                        fs: {}
                    }
                }
                $dagger: {
                    task: {}
                }
                exclude: ["README.md", "_build", "todoapp.cue", "node_modules"]
                path: "./"
            }
        }
        "./_build": {
            write: {
                contents: {
                    $dagger: {
                        fs: {}
                    }
                }
                $dagger: {
                    task: {}
                }
                path: "./_build"
            }
        }
    }
    network: {}
    env: {
        $dagger: {
            task: {}
        }
        APP_NAME:     string
        NETLIFY_TEAM: string
        NETLIFY_TOKEN: {
            $dagger: {
                secret: {}
            }
        }
    }
    commands: {}
    platform: {
        $dagger: {
            task: {}
        }
        os:   string
        arch: string
    }
}
actions: {
    deps: {
        steps: [{
            version: "3.15.0@sha256:21a3deaa0d32a8057914f36584b5288d2e5ecc984380bc0118285c70fa8c9300"
            steps: [{
                source: "index.docker.io/alpine:3.15.0@sha256:21a3deaa0d32a8057914f36584b5288d2e5ecc984380bc0118285c70fa8c9300"
                image: {
                    rootfs: {
                        $dagger: {
                            fs: {}
                        }
                    }
                    config: {}
                }
                output: {
                    rootfs: {
                        $dagger: {
                            fs: {}
                        }
                    }
                    config: {}
                }
            }, {
                input: {
                    rootfs: {
                        $dagger: {
                            fs: {}
                        }
                    }
                    config: {}
                }
                always: false
                mounts: {}
                ports: {}
                command: {
                    name: "apk"
                    args: ["add", "bash"]
                    flags: {
                        "-U":         true
                        "--no-cache": true
                    }
                }
                env: {}
                workdir:   string
                user:      string
                completed: true
                success:   true
                error: {
                    code:    0
                    message: null
                }
                output: {
                    rootfs: {
                        $dagger: {
                            fs: {}
                        }
                    }
                    config: {}
                }
                exit: 0
                export: {
                    rootfs: {
                        $dagger: {
                            fs: {}
                        }
                    }
                    files: {}
                    directories: {}
                }
            }, {
                input: {
                    rootfs: {
                        $dagger: {
                            fs: {}
                        }
                    }
                    config: {}
                }
                always: false
                mounts: {}
                ports: {}
                command: {
                    name: "apk"
                    args: ["add", "yarn"]
                    flags: {
                        "-U":         true
                        "--no-cache": true
                    }
                }
                env: {}
                workdir:   string
                user:      string
                completed: true
                success:   true
                error: {
                    code:    0
                    message: null
                }
                output: {
                    rootfs: {
                        $dagger: {
                            fs: {}
                        }
                    }
                    config: {}
                }
                exit: 0
                export: {
                    rootfs: {
                        $dagger: {
                            fs: {}
                        }
                    }
                    files: {}
                    directories: {}
                }
            }, {
                input: {
                    rootfs: {
                        $dagger: {
                            fs: {}
                        }
                    }
                    config: {}
                }
                always: false
                mounts: {}
                ports: {}
                command: {
                    name: "apk"
                    args: ["add", "git"]
                    flags: {
                        "-U":         true
                        "--no-cache": true
                    }
                }
                env: {}
                workdir:   string
                user:      string
                completed: true
                success:   true
                error: {
                    code:    0
                    message: null
                }
                output: {
                    rootfs: {
                        $dagger: {
                            fs: {}
                        }
                    }
                    config: {}
                }
                exit: 0
                export: {
                    rootfs: {
                        $dagger: {
                            fs: {}
                        }
                    }
                    files: {}
                    directories: {}
                }
            }]
            output: {
                rootfs: {
                    $dagger: {
                        fs: {}
                    }
                }
                config: {}
            }
            packages: {
                bash: {
                    version: ""
                }
                yarn: {
                    version: ""
                }
                git: {
                    version: ""
                }
            }
        }, {
            input: {
                rootfs: {
                    $dagger: {
                        fs: {}
                    }
                }
                config: {}
            }
            contents: {
                $dagger: {
                    fs: {}
                }
            }
            source: "/"
            dest:   "/src"
            include: []
            exclude: []
            output: {
                rootfs: {
                    $dagger: {
                        fs: {}
                    }
                }
                config: {}
            }
        }, {
            input: {
                rootfs: {
                    $dagger: {
                        fs: {}
                    }
                }
                config: {}
            }
            always:    false
            completed: true
            success:   true
            error: {
                code:    0
                message: null
            }
            script: {
                contents: """
                    yarn config set cache-folder /cache/yarn
                    yarn install
                    """
            }
            args: []
            mounts: {
                "Bash scripts": {
                    contents: {
                        $dagger: {
                            fs: {}
                        }
                    }
                    dest: "/bash/scripts"
                    type: "fs"
                }
                "/cache/yarn": {
                    dest: "/cache/yarn"
                    type: "cache"
                    contents: {
                        id:          "todoapp-yarn-cache"
                        concurrency: "shared"
                    }
                }
                "/src/node_modules": {
                    dest: "/src/node_modules"
                    type: "cache"
                    contents: {
                        id:          "todoapp-modules-cache"
                        concurrency: "shared"
                    }
                }
            }
            ports: {}
            command: {
                name: "bash"
                args: ["/bash/scripts/run.sh"]
                flags: {
                    "--norc": true
                    "-e":     true
                    "-o":     "pipefail"
                }
            }
            env: {}
            workdir: "/src"
            user:    string
            output: {
                rootfs: {
                    $dagger: {
                        fs: {}
                    }
                }
                config: {}
            }
            exit: 0
            export: {
                rootfs: {
                    $dagger: {
                        fs: {}
                    }
                }
                files: {}
                directories: {}
            }
        }]
        output: {
            rootfs: {
                $dagger: {
                    fs: {}
                }
            }
            config: {}
        }
    }
    test: {
        input: {
            rootfs: {
                $dagger: {
                    fs: {}
                }
            }
            config: {}
        }
        always:    false
        completed: true
        success:   true
        error: {
            code:    0
            message: null
        }
        script: {
            contents: "yarn run test"
        }
        args: []
        mounts: {
            "Bash scripts": {
                contents: {
                    $dagger: {
                        fs: {}
                    }
                }
                dest: "/bash/scripts"
                type: "fs"
            }
            "/src/node_modules": {
                dest: "/src/node_modules"
                type: "cache"
                contents: {
                    id:          "todoapp-modules-cache"
                    concurrency: "shared"
                }
            }
        }
        ports: {}
        command: {
            name: "bash"
            args: ["/bash/scripts/run.sh"]
            flags: {
                "--norc": true
                "-e":     true
                "-o":     "pipefail"
            }
        }
        env: {}
        workdir: "/src"
        user:    string
        output: {
            rootfs: {
                $dagger: {
                    fs: {}
                }
            }
            config: {}
        }
        exit: 0
        export: {
            rootfs: {
                $dagger: {
                    fs: {}
                }
            }
            files: {}
            directories: {}
        }
    }
    build: {
        run: {
            input: {
                rootfs: {
                    $dagger: {
                        fs: {}
                    }
                }
                config: {}
            }
            always:    false
            completed: true
            success:   true
            error: {
                code:    0
                message: null
            }
            script: {
                contents: "yarn run build"
            }
            args: []
            mounts: {
                "Bash scripts": {
                    contents: {
                        $dagger: {
                            fs: {}
                        }
                    }
                    dest: "/bash/scripts"
                    type: "fs"
                }
                "/src/node_modules": {
                    dest: "/src/node_modules"
                    type: "cache"
                    contents: {
                        id:          "todoapp-modules-cache"
                        concurrency: "shared"
                    }
                }
            }
            ports: {}
            command: {
                name: "bash"
                args: ["/bash/scripts/run.sh"]
                flags: {
                    "--norc": true
                    "-e":     true
                    "-o":     "pipefail"
                }
            }
            env: {}
            workdir: "/src"
            user:    string
            output: {
                rootfs: {
                    $dagger: {
                        fs: {}
                    }
                }
                config: {}
            }
            exit: 0
            export: {
                rootfs: {
                    $dagger: {
                        fs: {}
                    }
                }
                files: {}
                directories: {}
            }
        }
        contents: {
            input: {
                $dagger: {
                    fs: {}
                }
            }
            path: "/src/build"
            output: {
                $dagger: {
                    fs: {}
                }
            }
        }
    }
    deploy: {
        contents: {
            $dagger: {
                fs: {}
            }
        }
        site: string
        token: {
            $dagger: {
                secret: {}
            }
        }
        team:   ""
        domain: null
        create: true
        container: {
            input: {
                rootfs: {
                    $dagger: {
                        fs: {}
                    }
                }
                config: {}
            }
            completed: true
            success:   true
            error: {
                code:    0
                message: null
            }
            script: {
                directory: {
                    $dagger: {
                        fs: {}
                    }
                }
                filename: "deploy.sh"
            }
            args: []
            always: true
            mounts: {
                "Bash scripts": {
                    contents: {
                        $dagger: {
                            fs: {}
                        }
                    }
                    dest: "/bash/scripts"
                    type: "fs"
                }
                "Site contents": {
                    dest: "/src"
                    contents: {
                        $dagger: {
                            fs: {}
                        }
                    }
                    type: "fs"
                }
                "Netlify token": {
                    dest: "/run/secrets/token"
                    contents: {
                        $dagger: {
                            secret: {}
                        }
                    }
                    type: "secret"
                    uid:  0
                    gid:  0
                    mask: 256
                }
            }
            ports: {}
            command: {
                name: "bash"
                args: ["/bash/scripts/deploy.sh"]
                flags: {
                    "--norc": true
                    "-e":     true
                    "-o":     "pipefail"
                }
            }
            env: {
                NETLIFY_SITE_NAME:   string
                NETLIFY_SITE_CREATE: "1"
                NETLIFY_ACCOUNT:     ""
            }
            workdir: "/src"
            user:    string
            output: {
                rootfs: {
                    $dagger: {
                        fs: {}
                    }
                }
                config: {}
            }
            exit: 0
            export: {
                rootfs: {
                    $dagger: {
                        fs: {}
                    }
                }
                files: {
                    "/netlify/url":       string
                    "/netlify/deployUrl": string
                    "/netlify/logsUrl":   string
                }
                directories: {}
            }
        }
        url:       string
        deployUrl: string
        logsUrl:   string
    }
}
