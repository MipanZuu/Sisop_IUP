#!/bin/bash

select drinks in tea coffee water juice milk all nothing
do
  case $drinks in
    tea|coffee|water|all)
      echo "Sorry, we're out of them"
      ;;
    juice|milk)
      echo "Available"
    ;;
    nothing)
      break
    ;;
    *) echo "Does not exist in the menu"
    ;;
  esac
done
