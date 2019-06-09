                                         TASK 1

--script1 takes the name of the file containing the information as input
--It then parses the file line by line
--Each line is broken into three strings containing the name, permissions and the ddesired location of the file
--The script then uses the "file" command to determine the type of file. It does not rely on the file extension
--Example Keyword "pdf" in the output of file is used to test the file as pdf
--Depending on the type of file it stores the directory to which a file is to be copied in the variable "directory"
--It then parses the permission string of the file to determine permissions
--The presence of 'Read', 'Write' and 'Execute' in the string is used to determine permissions
--The permission is stored in the variable "permissions". Example permission may be 'rw' etc.
--Then mkdir is used to make the current directory if not already present.
--cp is used to copy the file to destination
--chmod is used to set the required permission.
--The script similarly loops for all the lines

                                          TASK 2

--The script first inputs the name of the team using read command.
--It then goes to an infinite while loop.
--Then wget is used to download the RSS feed xml file from espncricinfo
--Then the score of the desired team is extracted using command like cat,grep,cut,sed and stored in the variable "newscore"
--Then newscore is compared with variable oldscore to check for update
--If they are not equal a desktop notification is triggred showing progress.
--oldscore is updated.
--The script is paused for 15 seconds using sleep command.
--The loop then continues to check for further updates.
