#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

readonly LANGUAGE="$1"


function help_text_and_exit() {
  cat <<'END'
Usage:   bash run-tests.sh LANGUAGE
Example:

bash run-tests.sh java
bash run-tests.sh cpp

Running this script will compile and run the code in your language of choice
with the test data included here.

Error: please specify a valid language (got "$LANGUAGE")

END
  exit 1
}

if [ -z "$LANGUAGE" ]; then
  help_text_and_exit
fi

preScript=''
script=''

case "$LANGUAGE" in
  # javascript)
  #   command=node
  #   script='node javascript.js' ;;

  # python2)
  #   command=python
  #   script='python python2.py' ;;

  # python3)
  #   command=python3
  #   script='python3 python3.py' ;;

  java)
    command=java
    preScript='javac Solution.java'
    script='java Solution' ;;

  cpp)
   command=cpp
   preScript='g++ cpp.cpp -o cpp'
   script='./cpp' ;;

  *) help_text_and_exit ;;
esac


if ! command -v "$command" &> /dev/null; then
 cat <<END
❌ It seems like the command '$command' is not installed, which is needed to run code in $LANGUAGE

Please make sure your command line environment is properly set up
END

  exit 1
fi

if [ -n "$preScript" ]; then
  echo 'Compiling'
  echo "# $preScript"


  if ! $preScript; then
    echo "❌ Compilation failed. Please check the error messages and fix your code, then try again."
    exit 1
  fi
fi

# Declare a hashtable to store success/failure
files=()
successFailureMessages=()


function print_divider() {
  printf "%60s\n" " " | tr ' ' '-'
}

function print_double_divider() {
  printf "%60s\n" " " | tr ' ' '='
}


for file in "$DIR"/testCases/input*.txt; do
  # file is something like "input000.txt"
  # Get the number suffix:
  baseName=$(basename "$file")
  numericSuffix="${baseName//[^0-9]/}"

  mkdir -p runOutputs
  outputFile="$DIR/runOutputs/$baseName"
  print_double_divider
  echo
  echo "Running test on $baseName"

  # This variable is the command that we recommend running to run just
  # this one test case
  commandForTest="$script < $file"

  $script < "$file" > "$outputFile"
  exitCode="$?"

  echo

  if [ "$exitCode" != 0 ]; then
    # shellcheck disable=SC2059
    successFailureMessage=$(printf "❌ Execution failed with error exit code ($exitCode). To debug by running just this test, run the following command:\n\n$commandForTest")
  else
    echo 'Comparing outputs:'

    diffResult=$(diff --unified --ignore-blank-lines --ignore-space-change "$outputFile" "$DIR/testCases/output$numericSuffix.txt")
    diff --unified --ignore-blank-lines --ignore-space-change --color "$outputFile" "$DIR/testCases/output$numericSuffix.txt"

    successFailureMessage=''
    if [ -z "$diffResult" ]; then
      successFailureMessage='✅ Test passed! No differences'
    else
      # shellcheck disable=SC2059
      successFailureMessage=$(printf "❌ Test failed. To debug by running just this test, run the following command:\n\n$commandForTest")
    fi
  fi

  printf '\n%s\n' "$successFailureMessage"

  files+=("$baseName")
  successFailureMessages+=("$successFailureMessage")
done

echo
print_double_divider
echo
echo 'Summary'
echo
print_divider

# shellcheck disable=SC2068
for i in ${!files[@]}; do
  echo "${files[$i]}: ${successFailureMessages[$i]}"
  print_divider
done
