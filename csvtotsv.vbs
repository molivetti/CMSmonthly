'This VBScript is for converting CSV files to TSV (tab delimited) files by batch.
'Copy and paste it in Notepad and save the file with vbs extension (e.g. CSV2TSV.vbs) 
'Double click CSV2TSV.vbs to do the conversion.
'The converted files will be saved as *.tsv while the original files remain.
 
Option Explicit
Dim objWsShell, objFSO, objShellAp, objFolder, objFile, objFileTSV, objResult
Dim strPath, strLine, strNewLine, strNewFileName
Dim TotalFilesConverted, FileNameLength
Set objWsShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("scripting.filesystemobject")
Set objShellAp = CreateObject("Shell.Application")
Set objFolder = objShellAp.BrowseForFolder(0, "BATCH CONVERSION FROM CSV TO TSV FILES" _
& vbLf & vbLf & "Select a folder containing CSV files for the conversion.", 0, 17)
If objFolder is Nothing Then
msgBox "No folder is selected for conversion of CSV files."
WScript.Quit
Else
strPath = objFolder.Self.Path
objWsShell.CurrentDirectory = strPath
End if
TotalFilesConverted = 0
For Each objFile In objFSO.getfolder(strPath).Files
If UCase(Right(objFile.Name, 4)) = ".CSV" Then
objResult = objWsShell.Popup("Converting " & objFile.Name & " ...",3,"")
FileNameLength = Len(objFile.Name)-4
strNewFileName = Left(objFile.Name,FileNameLength) & ".tsv"
Set objFile = objFSO.OpenTextFile(objFile, 1)
Set objFileTSV = objFSO.CreateTextFile(strNewFileName)
Do Until objFile.AtEndOfStream
strLine = objFile.ReadLine
If instr(strLine,Chr(34)) =0 Then
strNewLine = Replace(strLine,",",vbTab)
Else
Call LineQuote(strNewLine)
End if
objFileTSV.WriteLine strNewLine
Loop
objFile.Close
TotalFilesConverted = TotalFilesConverted +1
objFileTSV.Close
End If
Next
If TotalFilesConverted =0 Then
MsgBox "No CSV files are found for conversion in the folder."
Else
MsgBox CStr(TotalFilesConverted) + " Files Converted from CSV to TSV."
End if
 
Sub LineQuote(strNewLine)
Dim LineLength, Linepos, blnQuote, Quotepos
LineLength = Len(strLine)
Linepos =1
strNewLine =""
blnQuote = False
Do While Linepos <= LineLength
Quotepos = instr(Mid(strLine,Linepos,LineLength-Linepos+1),Chr(34))
If Quotepos =1 Then
If Linepos < LineLength Then
If Mid(strLine,Linepos,2) = Chr(34) & Chr(34) and blnQuote Then
strNewLine = strNewLine & Chr(34)
Linepos = Linepos +2
Else 'one quote
If blnQuote Then
      blnQuote = False
Else
      blnQuote = True
End if
Linepos = Linepos +1
End if
Else 'last character
Linepos = Linepos +1
End if
Elseif Quotepos >1 Then
If blnQuote Then
strNewLine = strNewLine + Mid(strLine,Linepos,Quotepos-1)
Else 'not Quote
strNewLine = strNewLine + Replace(Mid(strLine,Linepos,Quotepos-1),",",vbTab)
End if
Linepos = Linepos +Quotepos -1
Else 'Quotepos =0
strNewLine = strNewLine + Replace(Mid(strLine,Linepos,LineLength-Linepos+1),",",vbTab)
Linepos = LineLength +1
End If
Loop
End Sub