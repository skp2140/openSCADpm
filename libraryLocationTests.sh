echo -e "\n"
echo "This is the libaray location tester."
echo -e "\n"
if [ "$1" == "help" ]; then
	echo "This runs a series of tests for library locations for ospm."
  echo ""
  echo "Required arguments are as follows:"
  echo -e "1. the library location\n"
  echo ""
  echo "Tests"
  echo "Test 1: Saving"
  echo "Test 2: Displaying"
  echo ""
  echo "Notes:"
  echo "* Test 2 is unlikely to work if test 1 does not."
	return
else
  testsPassed=0
  numberOfTests=2
  #location to save the library location
  lsll=/usr/local/lib/ospmLibSettings
  savedLib="no"
  if [ -f $lsll ]; then
    savedLib="yes"
  fi

  echo "Your libaray location is $1"
  echo "Your location to save libaray location is $lsll"
  echo -e "\n"

  echo  "Library Location Test 1: Saving"
  echo -e "\n"

  #Setup
  echo "Setup: Starting"
  userLSLL="notSet"
  if [ -f $lsll ]; then
    echo "removing old lsll"
    userLSLL=$(cat $lsll)
    rm $lsll
  fi
  echo "Setup: Complete"
  echo -e "\n"

  echo "Test Operation(s): Starting"
  source ospm.sh library save $1
  echo "Test Operation(s): Complete"
  echo -e "\n"

  #Evaluations
  echo "Evaluation(s): Starting"
  echo -e "\n"

  echo "Evaluation A: Starting"
  result=$(cat $lsll)

  T1evaluationsPassed=0

  if [ "$1" == "$result" ]; then
    let "T1evaluationsPassed = 1 + $T1evaluationsPassed"
    echo "Evaluation A: Passed"
  else
    echo "Evaluation A: Failed"
    echo "At $lsll"
    echo "Found: $result "
    echo "Expected: $1"
  fi

  echo "Evaluation A: Complete"
  echo -e "\n"

  echo "Evaluation(s): Complete"
  echo "$T1evaluationsPassed of 1 evaluations passed"
  if [ $T1evaluationsPassed == 1 ]; then
    let "testsPassed = $testsPassed + 1"
  fi
    echo -e "\n"

  #Teardown
  echo "Test Teardown: Starting"
  if [ -f $lsll ]; then
    rm $lsll
    if [ "$userLSLL" != "notSet" ]; then
      touch $lsll
      echo "restore"
      echo $userLSLL > $lsll
    fi

  fi
  echo "Test Teardown: Complete"
  echo -e "\n"
  echo "Test 1: Complete"
  echo -e "\n"


  echo  "Library Location Test 2: Displaying"
  echo -e "\n"
  #Setup
  echo "Setup: Starting"
  userLSLL="notSet"
  if [ -f $lsll ]; then
    userLSLL=$(cat $lsll)
    rm $lsll
  fi


  source ospm.sh library save $1

  echo "Setup: Complete"
  echo -e "\n"

  #Test operations
  echo "Test Operation(s): Starting"
  result=$(source ospm.sh library clean)
  echo "Test Operation(s): Complete"
  echo -e "\n"

  T2evaluationsPassed=0

  #Evaluations
  echo "Evaluation(s): Starting"
  echo -e "\n"

  echo "Evaluation A: Starting"

  if [ "$1" == "$result" ]; then
    let "T2evaluationsPassed = 1 + $T2evaluationsPassed"
    echo "Evaluation A: Passed"
  else
    echo "Evaluation A: Failed"
    echo -e "\n"
    echo "Running ospm.sh library"
    echo "Got: $result "
    echo "Expected: $1"
  fi

  echo "Evaluation A: Complete"
  echo -e "\n"

  echo "Evaluation(s): Complete"
  echo "$T2evaluationsPassed of 1 evaluations passed"
  if [ $T2evaluationsPassed == 1 ]; then
    let "testsPassed = $testsPassed + 1"
  fi
    echo -e "\n"

  #Teardown
  echo "Test Teardown: Starting"
  if [ -f $lsll ]; then
    rm $lsll
    if [ "$userLSLL" != "notSet" ]; then
      touch $lsll
      echo $userLSLL > $lsll
    fi
  fi
  echo "Test Teardown: Complete"

  echo -e "\n"
  echo "Test 2: Complete"
  echo -e "\n"

  if [ "$savedLib" == "yes" ]; then
    echo $1 > $lsll
  fi

  echo "Tests Finshed"
  echo "$testsPassed of $numberOfTests passed."

fi
