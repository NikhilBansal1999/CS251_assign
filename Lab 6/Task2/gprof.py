import os
print("Enter the name of program (c file):")
prog_name = input()

command = "gcc -no-pie -pg -o executable "+prog_name
os.system(command)

print("Does the program takes arguments(y or n):")
args = input()

if args == 'y':
    print("Enter the name of argument file")
    arg_file = input()
    file = open(arg_file,"r")
    for line in file:
        command = "./executable "+line
        os.system(command)
    file.close()
else:
    command = "./executable"
    os.system(command)

command = "gprof -bq executable gmon.out > analysis.txt"
os.system(command)

analysis_file = open("analysis.txt","r")
cont = 0
func_index = [] # [name,index,time]
for line in analysis_file:
    line_split = line.split()
    if line.startswith("Index by function name"):
        cont = 1
        continue
    if cont == 1 and len(line_split) > 1:
        i = 0
        while i < len(line_split):
            if len(line_split[i]) == 3 and line_split[i][0] == '[' and line_split[i][2] == ']':
                func_index.append([line_split[i+1],line_split[i][1]])
                i = i + 2
            else:
                i = i + 1


analysis_file.close()
command = "gprof -bp executable gmon.out > analysis.txt"
os.system(command)
analysis_file = open("analysis.txt","r")

line_count = 0
for line in analysis_file:
    line_count = line_count + 1
    if line_count > 5:
        line_split = line.split()
        func_name = line_split[-1]
        func_time = line_split[2]
        not_found = 1
        for i in range(len(func_index)):
            if func_index[i][0] == func_name:
                func_index[i].append(func_time)
                not_found = 0
                break

        if not_found:
            func_index.append([func_name,-2,func_time])

output_data = []
analysis_file.close()

command = "gprof -bq executable gmon.out > analysis.txt"
os.system(command)
count = 0
start_storing = 0
analysis_file = open("analysis.txt","r")
for line in analysis_file:
    count = count + 1
    if count > 6:
        start_storing = 1
    if start_storing:
        if line.startswith("---"):
            continue
        if line.startswith("Index by function name"):
            break
        else:
            line_split = line.split()
            to_add = 1
            for func in func_index:
                if len(line_split) > 2 and func[0] == line_split[-2]:
                    to_add = 0
                    break
            if to_add:
                if len(line_split) > 5:
                    if "/" not in line_split[2]:
                        func_index.append([line_split[-2],-1,line_split[2]])
                    else:
                        func_index.append([line_split[-2],-1,line_split[-5]])

analysis_file.close()

for func in func_index:
    command = "gprof -b -q"+func[0].strip()+" executable gmon.out > analysis.txt"
    os.system(command)
    analysis_file = open("analysis.txt","r")
    line_count = 0
    start_storing = 0
    for line in analysis_file:
        line_count = line_count + 1
        if line_count > 6:
            line_split = line.split()
            if len(line_split) > 1:
                if line_split[-2] == func[0] and ("/" not in line_split[-3]):
                    start_storing = 1
                    continue
        if start_storing:
            line_split = line.split()
            if line.startswith("---"):
                break
            if len(line_split) > 1:
                for child in func_index:
                    if len(line_split) > 2 and child[0] == line_split[-2]:
                        output_data.append([func[0],func[2],child[0],child[2]])
                        break

analysis_file.close()
output_csv = open("Timing_profile.csv","w")
to_write = "Func1,time1,Func2,time2\n"
output_csv.write(to_write)
print(len(output_data))
for data in output_data:
    to_write = str(data[0])+","+str(data[1])+","+str(data[2])+","+str(data[3])+"\n"
    output_csv.write(to_write)

output_csv.close()
