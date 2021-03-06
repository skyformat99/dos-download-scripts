. ./include/download.sh
. ./include/extract.sh

download_and_extract()
{
  IMGURL=$1
  IMGCNT=$2
  DESTINATION=$3
  SEPARATE_DIRS=$4

  mkdir $TMP_DIR
  for i in $(seq 1 "$IMGCNT")
  do
    download_file "`printf "$IMGURL" "$i"`" $TMP_DIR/disk$i.zip
    mkdir $TMP_DIR/ex$i
    extract_7z $TMP_DIR/disk$i.zip "" $TMP_DIR/ex$i
    IMAGE="${TMP_DIR}/ex$i/`ls \"${TMP_DIR}\"/ex$i/`"
    if [ $SEPARATE_DIRS = true ]; then
      mkdir $DESTINATION/disk$i
      mcopy -sn -i "$IMAGE" ::* $DESTINATION/disk$i
    else
      mcopy -sn -i "$IMAGE" ::* $DESTINATION
    fi
  done
}
