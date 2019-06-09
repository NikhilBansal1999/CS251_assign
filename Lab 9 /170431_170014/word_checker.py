fhand = open("new_Decrypted_message","r")
message = fhand.read()
fhand.close()

fhand = open("dictionary","r")
dictionary = list()
for line in fhand:
    dictionary.append(line.strip().lower())

fhand.close()
print("Size of dictionary is ",len(dictionary)," words")
message = message.strip().split()
counter = 0

for i in range(len(message)):
    message[i] = message[i].strip()
    flag = True
    while flag and len(message[i]) > 0:
        last_char = ord(message[i][-1])
        if last_char <= 122 and last_char >= 97:
            flag = False
        else:
            message[i] = message[i][0:len(message[i])-1]

for word in message:
    if word.strip().lower() in dictionary or len(word) == 0:
        counter = counter + 1
    else:
        print("'",word,"' not found in dictionary")

percentage = counter*100/len(message)
print(counter," out of ",len(message)," matched")
print("Accuracy:",percentage)
