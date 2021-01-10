# FLOW
clone後

# prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# terminal
setopt EXTENDED_GLOB

for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# zplug
brew install zplug

<https://qiita.com/devzooiiooz/items/a5f8fc33dee214f60f4e>
cd ~/.zprezto/modules/prompt/external/pure

cp pure.zsh pure.zsh_bak

cat pure.zsh_bak | grep ❯

３箇所書き換える

"PURE_PROMPT_SYMBOL:-%B%F{1}❯%F{3}❯%F{2}❯%f%b"

# dotfiles内で
cd ~/dotfiles

chmod +x install.sh

./install.sh
