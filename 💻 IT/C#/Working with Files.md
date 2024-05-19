#                  Write into file

```C#
StreamWriter streamWriter = new StreamWriter("existingFile.txt");
streamWriter.WriteLine("Hello World");
streamWriter.WriteLine("2nd line");
streamWriter.Close();
```


#                  Read from a file

```C#
StreamReader streamReader = new StreamReader("existingFile.txt");
string line1FromFile = streamReader.ReadLine();
string line2FromFile = streamReader.ReadLine();
streamReader.Close();
Console.WriteLine(line1FromFile);
Console.WriteLine(line2FromFile);
```