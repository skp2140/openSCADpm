list="installTestsList"
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
parseTestTarget="./parseTestTarget"
parseTestDest="./parseTestDest"

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


echo -e "\nThis is the parse tester.\n"
if [ "$1" == help ]; then
  echo -e "This runs a series of tests for parsing files with ospm.\n"
  echo -e "Optional arguments are as follows:"
  echo -e "1. the library location."
  echo -e "\nTests"
  echo -e "Test 1: Parse Save"
  return
else
  if [[ ! -z $1 ]]; then
    source ospm.sh library save $1
    libPath=$1
  else
    libPath=$(source ospm.sh library clean)
  fi
  slash=$(echo /)
  fullDirPathOfPackageWithoutDeps=$libPath$slash$dirOfPackageWithoutDeps
  fullDirPathOfPackageWithDeps=$libPath$slash$dirOfPackageWithDeps

  test 1
  currentTest="1"
  testStart $currentTest "Parse Save"
  setUpStarting
  if [[ -f $parseTestDest ]]; then
    rm $parseTestDest
  fi
  setUpComplete

  testOperationsStarting
  source ospm.sh parse save $parseTestTarget $parseTestDest
  testOperationsComplete

  evaluationsStarting

  T1evaluationsPassed=0

  currentEval="A"
  evaluationStarting $currentEval

  if [[ -f $parseTestDest ]]; then
    evaluationPassed $currentEval
    let "T1evaluationsPassed = $T1evaluationsPassed + 1"
  else
    evaluationFailed $currentEval "Looked for the parse save destination" "Was not found." $parseTestDest
  fi

  # currentEval="B"
  # evaluationStarting $currentEval
  #
  # $lines=$(wc -l $parseTestDest)
  # if  [[ "$lines" == "2" ]]; then
  #   evaluationPassed $currentEval
  #   let "T1evaluationsPassed = $T1evaluationsPassed + 1"
  # else
  #   evaluationFailed $currentEval "Checked the line count of $parseTestDest" "$lines" "2"
  # fi

  currentEval="B"
  evaluationStarting $currentEval

  if grep -Fxq "$packageWithoutDeps" $parseTestDest ; then
    evaluationPassed $currentEval
    let "T1evaluationsPassed = $T1evaluationsPassed + 1"
  else
    evaluationFailed $currentEval "Looked for $packageWithoutDeps in $parseTestDest" "Was $(cat $parseTestDest)" "$packageWithoutDeps"
  fi

  currentEval="C"
  evaluationStarting $currentEval

  if  grep -Fxq "$packageWithDeps" $parseTestDest ; then
    evaluationPassed $currentEval
    let "T1evaluationsPassed = $T1evaluationsPassed + 1"
  else
    evaluationFailed $currentEval "Looked for $packageWithDeps in $parseTestDest" "Was $(cat $parseTestDest)" "$packageWithDeps"
  fi

  evaluationsComplete $T1evaluationsPassed "3"

  if [[ "$T1evaluationsPassed" == "3" ]]; then
    let "testsPassed = $testsPassed + 1"
  fi

  testTearDownStarting
  if [[ -f $parseTestDest ]]; then
    rm $parseTestDest
  fi
  testTearDownComplete

  testComplete $currentTest


  testsComplete $testsPassed $numberOfTests

fi
