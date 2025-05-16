gh auth switch
email=$(gh api user --jq .email)
git config --global user.email $email
