LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE

STAT()
{
if [ $? -eq 0 ]; then
 echo "Success"
else
 echo "Fail"
 exit
fi
}