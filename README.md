# dotfiles
These are my linux config files, I jump around from distro to distro every now and then so it's convinient to have my dotfiles stored here.

I use [GNU Stow](https://www.gnu.org/software/stow/) to manage my dotfiles, so if anyone wants to try out my configs you'll need to install it first.

### Install
Clone the repo in your `$HOME` or `~` directory
```
git clone https://github.com/RubinBarclay/dotfiles.git
```

In the `dotfiles` directory `stow` the configs you want
```
stow nvim # for just my neovim config
```
```
stow */ # for everything
```
