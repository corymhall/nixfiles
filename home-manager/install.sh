# Where first arg is directory under machines, can be one of macos, fedora, nixos
#!/bin/bash
mkdir -p $HOME/.config
ln -s $(pwd) $HOME/.config

platform=""
update=0

while getopts ":ui:p:" opt; do
  case $opt in
    u) update=1
      ;;
    i) input=$OPTARG
      ;;
    p) platform=$OPTARG
      ;;
    \?)
      echo "need to provide platform 'mac' | 'ubuntu-server'"
      exit 0
      ;;
  esac
done

command=""
if [ $update -gt 0 ]
then
  command=" --update-input $input"
fi


fullcommand="nix-shell -p nixUnstable --command \"nix build$command --experimental-features 'nix-command flakes' '.#$platform'\""
echo "running command $fullcommand"
nix-shell -p nixUnstable --command "nix build$command --experimental-features 'nix-command flakes' '.#$platform'"

./result/activate
