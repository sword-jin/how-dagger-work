package deep_into_dagger

import "testing"

func TestSay(t *testing.T) {
	type args struct {
		name string
	}
	tests := []struct {
		name string
		args args
		want string
	}{
		{
			"test say hello to github",
			args{
				name: "github",
			},
			"Hello github",
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := Say(tt.args.name); got != tt.want {
				t.Errorf("Say() = %v, want %v", got, tt.want)
			}
		})
	}
}
