LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE

STAT()
{
if [ $? -eq 0 ]; then
 echo -e "\e[1;32m SUCCESS\e[0m"
else
 echo "Fail"
 exit
fi
}