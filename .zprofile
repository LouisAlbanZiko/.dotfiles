if [ -f ~/.cargo/env ]; then
	. "$HOME/.cargo/env"
fi

if [ -f ~/.local/vulkansdk/1.4.313.0/setup-env.sh ]; then
	source ~/.local/vulkansdk/1.4.313.0/setup-env.sh
fi

cat ~/.config/environment.d/env.conf | sed '/^#/d' | sed '/^$/d' | while IFS='=' read -r name value; do
	export "$name=$(eval echo $value)";
done
#PATH=~/.local/bin:$PATH

