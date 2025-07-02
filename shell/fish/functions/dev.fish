function dev --description 'Quick access to development directories'
  switch $argv[1]
    case projects p
      cd $PROJECTS_PATH
    case repos r
      cd $REPOS_PATH
    case dotfiles dot d
      cd $DOTFILES_PATH
    case workspace w
      cd $WORKSPACE_PATH
    case dsa
      cd $DSA_PATH
    case cpp
      cd $CPP_PATH
    case '*'
      echo "Available: projects|p, repos|r, dotfiles|dot|d, workspace|w, dsa, cpp"
      return 1
  end
end
