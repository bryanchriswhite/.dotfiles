
# get current branch in git repo
function parse_git_branch() {
  BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  if [ ! "${BRANCH}" == "" ]
  then
    STAT=`parse_git_dirty`
    echo -e "[${BRANCH}${STAT}]"
  else
    echo ""
  fi
}

# get current status of git repo
function parse_git_dirty {
  status=`git status 2>&1 | tee`
  dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
  untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
  ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
  newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
  renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
  deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
  bits=''
  if [ "${renamed}" == "0" ]; then
    bits="${renamed_color}>\e[0m${bits}"
  fi
  if [ "${ahead}" == "0" ]; then
    bits="${ahead_color}*\e[0m${bits}"
  fi
  if [ "${newfile}" == "0" ]; then
    bits="${new_color}+\e[0m${bits}"
  fi
  if [ "${untracked}" == "0" ]; then
    bits="${untracked_color}?\e[0m${bits}"
  fi
  if [ "${deleted}" == "0" ]; then
    bits="${deleted_color}x\e[0m${bits}"
  fi
  if [ "${dirty}" == "0" ]; then
    bits="${dirty_color}!\e[0m${bits}"
  fi
  if [ ! "${bits}" == "" ]; then
    echo -e " \e[1m${bits}\e[0m"
  else
    echo ""
  fi
}
