#!/bin/csh -f

# 회사에서 csh, tcsh 사용. 
# grep 결과를 복사 붙여넣기해서 파일을 열어보는데
# 매번 vir을 치고 :를 지우고 스페이스바 + '+' 바꿔주는 작업이 귀찮아서 만듬.
# 기존 grep 수행 결과  -> xxx.c:73  blah blah blah
# 이 스크립트 수행 하면 -> vir xxx.c +73  blah blah blah

# 세팅 
# alias vir 'vim -R'

if ($#argv < 2) then
    echo "USAGE : $0 pattern file (current argv cnt: $#argv)"
    exit 1
endif

set OS = `uname`
if ("$OS" == "SunOS") then
    set grep_util = /usr/xpg4/bin/grep
else
    set grep_util = /bin/grep
endif

@ i = 2
while ($i < $#argv)
    $grep_util -nH --color=always $1 $argv[$i] | sed 's/c:/c +/g' | sed 's/:/ /1' | sed 's/^/vir /g'
    @ i++
end
