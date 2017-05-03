list="versionlTestsList"
packageWithDeps="brennangw ospm_hello 0.4"
dirOfPackageWithDeps="brennangw-ospm_hello-0.4"
packageWithoutDeps="brennangw ospm_echo 0.1"
dirOfPackageWithoutDeps="brennangw-ospm_echo-0.1"
setUpStartingMessage="Startup: Starting"
setUpCompleteMessage="Setup: Complete"
testOperationsStartingMessage="Test Operation(s): Starting"
testOperationsCompleteMessage="Test Operation(s): Complete"
evaluationsStartingMessage="Evaluation(s): Starting"
evaluationsCompleteMessage="Evaluation(s): Complete"
testTearDownStartingMessage="Test Teardown: Starting"
testTearDownCompleteMessage="Test Teardown: Complete"

testsPassed=0
numberOfTests=1

function setUpComplete {
  echo "$setUpCompleteMessage"
}

function setUpStarting {
  echo "$setUpStartingMessage"
}

function testOperationsComplete {
  echo "$testOperationsCompleteMessage"
}

function testOperationsStarting {
  echo "$testOperationsStartingMessage"
}

function evaluationsStarting {
  echo "$evaluationsStartingMessage"
}

function evaluationsComplete {
  echo "$evaluationsCompleteMessage"
}

function testTearDownComplete {
  echo "$testTearDownCompleteMessage"
}

function testTearDownStarting {
  echo "$testTearDownStartingMessage"
}

function testsComplete {
  echo "Tests Finshed"
  echo "$testsPassed of $numberOfTests passed."
}

function testStart {
  echo "Test $1: $2"
}

function evaluationStarting {
  echo "Evaluation $1: Starting"
}

function evaluationsComplete {
  echo "$1 of $2 evaluations passed."
}

function testComplete {
  echo "Test $1: Complete"
}

function evaluationPassed {
  echo "Evaluation $1: Passed"
}

function evaluationFailed {
  echo "Evaluation $1: Failed"
  echo "Detail: $2"
  echo "Was: $3"
  echo "Expected: $4"
}

function createList {
  touch $list
  echo $packageWithDeps > $list
}

function deleteList {
  rm $list
}


echo -e "\nThis is the version tester.\n"
if [ "$1" == help ] || [ "$1" == install ] || [ "$1" == uninstall ] || [ "$1" == library ]; then
  echo -e "This runs a series of tests for determining the version of ospm.\n"
  echo -e "Optional arguments are as follows:"
  echo -e "1. version"
  echo -e "\nTests"
  echo -e "Test 1:  running version command"
  return
else
  if [ "$1" == version ]; then # when the first variable is not empty
    print_output=$(source ospm.sh version)
    print_output=$(cat $print_output)
    echo $print_output
  else
    echo "gggggg"
    print_output=""
  fi

  #test 1
  currentTest="1"
  testStart $currentTest "Running Version Command"

  setUpStarting
  setUpComplete

  testOperationsStarting

  testOperationsComplete

  evaluationsStarting

  T1evaluationsPassed=0

  currentEval="A"
  evaluationStarting currentEval

  echo "$print_output"

  NC='\033[0m'
  YELLOW='\033[1;33m'

  if [[ "$print_output" == "" ]]; then     # check if $lib has the right output
    evaluationPassed "A"
    let "testsPassed = $testsPassed + 1"
    let "T1evaluationsPassed = $T1evaluationsPassed + 1"
  else
    evaluationFailed "A" "Version number dismatch" "N/A" "ospm 0.0.1"
  fi

  evaluationsComplete $T1evaluationsPassed "1"

  evaluationsComplete

  testTearDownStarting

  testTearDownComplete

  testComplete $currentTest

  testsComplete $testsPassed $numberOfTests

fi
