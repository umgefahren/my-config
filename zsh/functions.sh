cdd () {
	  mkdir $@
	  cd $@
}

goto () {
	  gotoAlias=$1

	  if [[ "$gotoAlias" = "my-config" ]]
	  then 
		    cd "$HOME/my-config/"
	  elif [[ "$gotoAlias" = "drafts" ]]
	  then
		    cd "$HOME/drafts/"
	  elif [[ "$gotoAlias" = "home" ]]
	  then
		    cd "$HOME"
	  elif [[ "$gotoAlias" = "tmp" ]]
	  then
		    cd "/tmp/"
	  elif [[ "$gotoAlias" = "mktmp" ]]
	  then
		    cdd /tmp/$(uuidgen)
	  elif [[ "$gotoAlias" = "help" ]]
	  then
		    echo "Possible values for the goto shortcut are:"
		    echo "\tmy-config -> ~/my-config/"
		    echo "\tdrafts -> ~/drafts/"
		    echo "\thome -> ~"
		    echo "\ttmp -> /tmp/"
		    echo "\tmktmp -> cdd /tmp/< uuid >"
		    echo "\thelp -> prints this help message"
	  else
		    echo "Parameter(s) $@ is unknown"
	  fi
}

findmorehelp () {
	  eval "find-help $@ -d | less"
}
