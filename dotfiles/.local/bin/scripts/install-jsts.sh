# Install node 
curl -o- https://fnm.vercel.app/install | bash
fnm install 22
npm install -g typescript ts-node tsx


# Install bun as better general purpose alternative to node js
curl -fsSL https://bun.sh/install | bash 
# Manually add bun to path in .zshrc
echo 'export PATH="$PATH:$HOME/.bun/bin"' >> ~/.zshrc
