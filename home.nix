{ config, pkgs, ...}:

{
	home.username = "becker";
	home.homeDirectory = "/home/becker";
	home.stateVersion = "24.11";

	programs.bash = {
		enable = true;
		shellAliases = {
		  btw = "echo i use nixos btw";
		  nrs = "sudo nixos-rebuild switch";		
		};
	
	initExtra = ''
	  export PS1='\[\e[91m\]\u\[\e[0m\] in \[\e[38;5;197m\]\w\[\e[0m\] \\$ '
	'';
	};

	programs.alacritty = {
	 enable = true;
	 settings = {
	  window.opacity = 0.9;
	  font.normal = {
		family = "JetBrains Mono";
		style = "Regular";
	    };
		 font.size = 16; 
	 };
	};

	home.file.".config/bat/config".text = ''
	--theme="Nord"
	--style="numbers,changes,grid"
	--paging=auto
	'';

	home.packages = with pkgs; [ 
	  bat
	];
 }


