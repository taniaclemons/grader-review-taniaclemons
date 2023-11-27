CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

cp TestListExamples.java grading-area/

cd grading-area
javac -cp $CPATH TestListExamples.java

tests=`find grading-area -name "*.txt"`

for file in $tests
do
    output=`java GradeServer < $file`
    expected=`cat $file.expect`

    if [[$output != $expected]]
        then
        echo "$file: Mismatched output and expected"
        echo "Expected: $expected, got $output"
        echo ""
    else
        echo "$file: Test passed"
    fi
done
