for repo in "group-a" "group-b" "group-c" "group-d" "group-e" "group-f" "group-g" "group-h" "group-i" "group-j" "group-k" "group-l" "group-m" "group-n"
do sqlite3 -csv ${repo}.db "select * from milestone;" > ./dmp/${repo}_milestone.csv
sqlite3 -csv ${repo}.db "select * from issue;" > ./dmp/${repo}_issue.csv
sqlite3 -csv ${repo}.db "select * from event;" > ./dmp/${repo}_event.csv
sqlite3 -csv ${repo}.db "select * from comment;" > ./dmp/${repo}_comment.csv
sqlite3 -csv ${repo}.db "select * from commits;" > ./dmp/${repo}_commits.csv
done
find ./dmp/ -size  0 -exec rm '{}' \;