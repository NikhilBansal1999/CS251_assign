import os

print("Enter the name of program to profile (c file)")
prog_name = input()
command = "gcc -fprofile-arcs -ftest-coverage -o executable "+prog_name
os.system(command)

print("Does the program accept arguments(y or n):")
args = input()
if args == 'y':
    print("Enter the name of file containing test cases")
    test_file = input()
    fhandle = open(test_file,"r")
    for line in fhandle:
        command = "./executable "+line
        os.system(command)
    fhandle.close()
else:
    command = "./executable"
    os.system(command)

command = "gcov -b -c -i "+prog_name
os.system(command)

out_name = prog_name+".gcov"
gcov_out = open(out_name,"r")

output_file = open("profile_information_line.csv","w")
output_file.write("                Frequency of line execution                 \n")
line_count = dict()
branch = dict()
curr_branch = -1
next_line = -1
for line in gcov_out:
    line_split = line.split(":")
    second_split = line_split[1].split(',')
    if line_split[0] == "lcount":
        data_to_write = str(int(second_split[0]))+","+str(int(second_split[1]))+"\n"
        output_file.write(data_to_write)
        line_count[str(second_split[0])] = second_split[1]

gcov_out.close()
output_file.close()

command = "gcov -b "+prog_name
os.system(command)

out_name = prog_name+".gcov"
gcov_out = open(out_name,"r")

output_file = open("profile_information_branch.csv","w")
output_file.write("                Branch Bias                 \n")

prev_line=""
for line in gcov_out:
    line_split = line.split()
    if len(line_split) > 3 and line_split[0] == "branch" and (int(line_split[1]) == 0):
        data_to_write = str(int(prev_line.split(":")[1]))+","+line_split[3]+"\n"
        output_file.write(data_to_write)
    prev_line = line

gcov_out.close()
output_file.close()
