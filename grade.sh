CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

# clone the repository of the student submission
rm -rf submissions
git clone $1 submissions
echo 'Finished cloning'

# check the student code has the correct file(s) submitted.
if [ ! -f ./submissions/ListExamples.java ]; then
    echo "You might have the wrong file submitted, please do check again!"
    exit 1
fi

# Copy the student submission out of the submissions folder, and put it to the tests folder
mkdir ./tests
cp ./submissions/ListExamples.java ./tests
cp ./TestListExamples.java ./tests

# Compile the student's code and test files
javac -cp $CPATH ./tests/*.java

# Check if compilation succeeded
if [ $? -ne 0 ]; then
    echo "Error: Compilation failed"
    exit 1
fi

# Run the tests using JUnit and report the grade
java -cp $CPATH org.junit.runner.JUnitCore ./tests/TestListExamples | grep . > tests_results.txt
if [ $? -eq 0 ]; then
    echo "Congratulations, you passed the tests!"
else
    echo "Sorry, you failed the tests."
fi

exit 0
