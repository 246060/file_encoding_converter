#!/bin/bash

function traverse(){

if [ -z $1 ] 
then
  echo "ERROR : Please write argument for path."
  return ;
fi

DIRECTORY_PATH=$1;
# echo "DIRECTORY_PATH : $DIRECTORY_PATH";

for f in $DIRECTORY_PATH/* ;
do  

  FILE_NAME=$f;
  #echo "FILE_NAME : $FILE_NAME";
  CURRENT_ENCODING=`file -bi $FILE_NAME | cut -d "=" -f2`;
  
  if [ "$CURRENT_ENCODING" == "iso-8859-1" ];
  then 
    echo "Encoding Converting : $FILE_NAME : $CURRENT_ENCODING(euc-kr) -> utf-8 : Success"
    iconv -c -f euc-kr -t utf-8 ${FILE_NAME} > ${FILE_NAME}.emp 
    mv ${FILE_NAME}.emp ${FILE_NAME}
  fi

   if [ -d "$FILE_NAME" ]; then
        # $FILE_NAME is a directory
        # echo "$FILE_NAME : this is directory";
        cd $FILE_NAME && traverse .
    fi
done

}


echo "Converting Start..."
# first function call
traverse $1
echo "Converting Finished."
