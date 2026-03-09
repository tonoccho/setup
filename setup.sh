#/usr/bin/env bash
# get script file directory
export SCRIPT_DIRECTORY="$(cd "$(dirname "${0}")"; pwd)"
export COMPONENTS_DIRECTORY=${SCRIPT_DIRECTORY}/components

echo -n "running apt update ... "
if sudo apt update > /dev/null 2>&1
then
  echo "done"
else
  echo "fail"
  exit 255
fi

for i in $(ls ${SCRIPT_DIRECTORY}/components | sort)
do
  echo "invoking ${i}"
  ${SCRIPT_DIRECTORY}/components/${i}
done