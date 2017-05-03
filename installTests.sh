#!/bin/bash
list="installTestsList"
packageWithDeps="brennangw ospm_hello 0.4"
dirOfPackageWithDeps="brennangw-ospm_hello-0.4"
packageWithoutDeps="brennangw ospm_echo 0.1"
dirOfPackageWithoutDeps="brennangw-ospm_echo-0.1"
setUpStartingMessage="Startup: Starting"
setUpCompleteMessage="Setup: Complete"
testOperationsStartingMessage="Test Operation(s): Starting"
testOperationsCompleteMessage="Test Operation(s): Starting"
evaluationsStartingMessage="Evaluation(s): Starting"
evaluationsCompleteMessage="Evaluation(s): Complete"
testTearDownStartingMessage="Test Teardown: Starting"
testTearDownCompleteMessage="Test Teardown: Complete"

testsPassed=0
numberOfTests=3

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


echo -e "\nThis is the install tester.\n"
if [ "$1" == help ]; then
  echo -e "This runs a series of tests for installig packages with ospm.\n"
  echo -e "Optional arguments are as follows:"
  echo -e "1. the library location."
  echo -e "\nTests"
  echo -e "Test 1: Install w/no dependencies"
  echo -e "Test 2: Install w/dependencies"
  echo -e "Test 3: Install via list w/dependencies"
  return
else
  if [[ ! -z $1 ]]; then
    source ospm library save $1
    libPath=$1
  else
    libPath=$(source ospm library clean)
  fi
  slash=$(echo /)
  fullDirPathOfPackageWithoutDeps=$libPath$slash$dirOfPackageWithoutDeps
  fullDirPathOfPackageWithDeps=$libPath$slash$dirOfPackageWithDeps

  #test 1
  currentTest="1"
  testStart $currentTest "Install w/no Dependencies"
  setUpStarting
  if [[ -d $fullDirPathOfPackageWithoutDeps ]]; then
    rm -rf $fullDirPathOfPackageWithoutDeps
  fi
  setUpComplete

  testOperationsStarting
  source ospm install $packageWithoutDeps
  testOperationsComplete

  evaluationsStarting

  T1evaluationsPassed=0

  currentEval="A"
  evaluationStarting currentEval

  if [[ -d $fullDirPathOfPackageWithoutDeps ]]; then
    evaluationPassed "A"
    let "testsPassed = $testsPassed + 1"
    let "T1evaluationsPassed = $T1evaluationsPassed + 1"
  else
    evaluationFailed "A" "Looked for installed dir" "Not found" $dirOfPackageWithoutDeps
  fi

  evaluationsComplete $T1evaluationsPassed "1"

  evaluationsComplete

  testTearDownStarting
  if [[ -d $fullDirPathOfPackageWithoutDeps ]]; then
    rm -rf $fullDirPathOfPackageWithoutDeps
  fi
  testTearDownComplete

  testComplete $currentTest


  #test 2

  currentTest="2"
  testStart $currentTest "Install w/Dependencies"

  setUpStarting

  if [[ -d $fullDirPathOfPackageWithoutDeps ]]; then
    rm -rf $fullDirPathOfPackageWithoutDeps
  fi

  if [[ -d $fullDirPathOfPackageWithDeps ]]; then
    rm -rf $fullDirPathOfPackageWithDeps
  fi

  setUpComplete


  testOperationsStarting
  source ospm install $packageWithDeps
  testOperationsComplete

  evaluationsStarting

  T2evaluationsPassed=0

  currentEval="B"
  evaluationStarting currentEval

  if [[ -d $fullDirPathOfPackageWithoutDeps ]]; then
    evaluationPassed currentEval
    let "T2evaluationsPassed = $T2evaluationsPassed + 1"
  else
    evaluationFailed currentEval "Looked for installed dir" "Not found" $dirOfPackageWithoutDeps
  fi


  evaluationStarting currentEval



  if [[ -d $fullDirPathOfPackageWithoutDeps ]]; then
    evaluationPassed currentEval
    let "T2evaluationsPassed = $T2evaluationsPassed + 1"
  else
    evaluationFailed currentEval "Looked for installed dir" "Not found" $dirOfPackageWithoutDeps
  fi

  evaluationsComplete $T2evaluationsPassed "2"

  if [[ "$T2evaluationsPassed" == "2" ]]; then
    let "testsPassed = $testsPassed + 1"
  fi

  testTearDownStarting
  if [[ -d $fullDirPathOfPackageWithoutDeps ]]; then
    rm -rf $fullDirPathOfPackageWithoutDeps
  fi

  if [[ -d $fullDirPathOfPackageWithDeps ]]; then
    rm -rf $fullDirPathOfPackageWithDeps
  fi
  testTearDownComplete

  testComplete $currentTest



  # currentTest="3"
  # testStart $currentTest "Install via list w/Dependencies"
  # testComplete $currentTest

  #test 3

  currentTest="3"
  testStart $currentTest "Install via List w/Dependencies"

  setUpStarting

  if [[ -d $fullDirPathOfPackageWithoutDeps ]]; then
    rm -rf $fullDirPathOfPackageWithoutDeps
  fi

  if [[ -d $fullDirPathOfPackageWithDeps ]]; then
    rm -rf $fullDirPathOfPackageWithDeps
  fi

  listName="opsmInstallTestingList"
  if [[ -f $listName ]]; then
    rm $listName
  fi

  touch $listName
  echo "brennangw ospm_hello 0.4" > $listName

  setUpComplete


  testOperationsStarting
  source ospm install list $listName
  testOperationsComplete

  evaluationsStarting

  T2evaluationsPassed=0

  currentEval="B"
  evaluationStarting currentEval

  if [[ -d $fullDirPathOfPackageWithoutDeps ]]; then
    evaluationPassed currentEval
    let "T2evaluationsPassed = $T2evaluationsPassed + 1"
  else
    evaluationFailed currentEval "Looked for installed dir" "Not found" $dirOfPackageWithoutDeps
  fi


  evaluationStarting currentEval



  if [[ -d $fullDirPathOfPackageWithoutDeps ]]; then
    evaluationPassed currentEval
    let "T2evaluationsPassed = $T2evaluationsPassed + 1"
  else
    evaluationFailed currentEval "Looked for installed dir" "Not found" $dirOfPackageWithoutDeps
  fi

  evaluationsComplete $T2evaluationsPassed "2"

  if [[ "$T2evaluationsPassed" == "2" ]]; then
    let "testsPassed = $testsPassed + 1"
  fi

  testTearDownStarting
  if [[ -d $fullDirPathOfPackageWithoutDeps ]]; then
    rm -rf $fullDirPathOfPackageWithoutDeps
  fi

  if [[ -d $fullDirPathOfPackageWithDeps ]]; then
    rm -rf $fullDirPathOfPackageWithDeps
  fi

  if [[ -f $listName ]]; then
    rm $listName
  fi

  testTearDownComplete

  testComplete $currentTest


  testsComplete $testsPassed $numberOfTests

fi
