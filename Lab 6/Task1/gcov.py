import os

print("Enter the name of program to profile (c file)")
prog_name = input()

print("Enter the name of file containing test cases")
test_file = input()
fhandle = open(test_file,"r")

output_file = open("profile_information_branch.csv","w")
output_file.write("branch_number,branch_bias,case_number\n")
output_file.close()

fhandle = open(test_file,"r")
i=0
for line in fhandle:
    if i>4:
        break
    i=i+1
    command = "gcc -fprofile-arcs -ftest-coverage -o executable "+prog_name+" > /dev/null 2>/dev/null"
    os.system(command)
    command = "./executable "+line
    os.system(command)

    command = "gcov -b "+prog_name
    os.system(command)

    out_name = prog_name+".gcov"
    gcov_out = open(out_name,"r")

    output_file = open("profile_information_branch.csv","a")

    prev_line=""
    for line in gcov_out:
        line_split = line.split()
        if len(line_split) > 3 and line_split[0] == "branch" and (int(line_split[1]) == 0):
            data_to_write = str(int(prev_line.split(":")[1]))+","+line_split[3][0:len(line_split[3])-1]+","+str(i)+"\n"
            output_file.write(data_to_write)
        prev_line = line

    gcov_out.close()
    output_file.close()
