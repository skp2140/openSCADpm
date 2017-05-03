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
numberOfTests=2

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


echo -e "\nThis is the uninstall tester.\n"
if [ "$1" == help ]; then
  echo -e "This runs a series of tests for installig packages with ospm.\n"
  echo -e "Optional arguments are as follows:"
  echo -e "1. the library location."
  echo -e "\nTests"
  echo -e "Test 1: Uninstall soft"
  echo -e "Test 2: Uninstall force"
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
  testStart $currentTest "Uninstall Soft"
  setUpStarting
  if [[ -d $fullDirPathOfPackageWithoutDeps ]]; then
    rm -rf $fullDirPathOfPackageWithoutDeps
  fi
  source ospm.sh install $packageWithoutDeps
  setUpComplete

  testOperationsStarting
  source ospm.sh uninstall $packageWithoutDeps
  testOperationsComplete

  evaluationsStarting

  T1evaluationsPassed=0

  currentEval="A"
  evaluationStarting currentEval

  if [[ ! -d $fullDirPathOfPackageWithoutDeps ]]; then
    evaluationPassed "A"
    let "testsPassed = $testsPassed + 1"
    let "T1evaluationsPassed = $T1evaluationsPassed + 1"
  else
    evaluationFailed "A" "Looked for the lack of installed dir" "Was found at $fullDirPathOfPackageWithoutDeps" $dirOfPackageWithoutDeps
  fi

  evaluationsComplete $T1evaluationsPassed "1"

  evaluationsComplete

  testTearDownStarting
  if [[ -d $fullDirPathOfPackageWithoutDeps ]]; then
    rm -rf $fullDirPathOfPackageWithoutDeps
  fi
  testTearDownComplete

  testComplete $currentTest


  # test 2
  currentTest="2"
  testStart $currentTest "Uninstall Force"
  setUpStarting
  if [[ -d $fullDirPathOfPackageWithoutDeps ]]; then
    rm -rf $fullDirPathOfPackageWithoutDeps
  fi
  source ospm.sh install $packageWithoutDeps
  setUpComplete

  testOperationsStarting
  packageWithoutDepsArr=($packageWithoutDeps)
  source ospm.sh uninstall ${packageWithoutDepsArr[0]} ${packageWithoutDepsArr[1]} ${packageWithoutDepsArr[2]} force
  testOperationsComplete

  evaluationsStarting

  T1evaluationsPassed=0

  currentEval="A"
  evaluationStarting currentEval

  if [[ ! -d $fullDirPathOfPackageWithoutDeps ]]; then
    evaluationPassed "A"
    let "testsPassed = $testsPassed + 1"
    let "T1evaluationsPassed = $T1evaluationsPassed + 1"
  else
    evaluationFailed "A" "Looked for the lack of installed dir" "Was found at $fullDirPathOfPackageWithoutDeps" $dirOfPackageWithoutDeps
  fi

  evaluationsComplete $T1evaluationsPassed "1"

  evaluationsComplete

  testTearDownStarting
  if [[ -d $fullDirPathOfPackageWithoutDeps ]]; then
    rm -rf $fullDirPathOfPackageWithoutDeps
  fi
  testTearDownComplete

  testComplete $currentTest


  testsComplete $testsPassed $numberOfTests

fi
