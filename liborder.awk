# ������ ������ - ����������� ��������� ������ ���� ������� ���� xxx<yyy
# (������ xxx ������ ������ ����� yyy) ��� xxx>yyy
# ������ ������ - ����������� ��������� ������ ���������
# ������ ������� ��� ��������� �� ������

BEGIN  {
 # ��������� ������ � ������������
  getline;
  allreq = $0;
  for ( i=1; i<=NF; i++ )  {
    if ( split($i,a,",")==2 )
      { orders[a[1]"@"a[2]] = 1 }
    else
      { print ( "Invalid library order requirement: " $i );  exit 1; }
    }
 # ��������� ������ � ������������
  getline;
 # ���� ��������� ���, �� ������ ������
  if ( NF==0 )  exit 0;
 # ���� ���������� ���, �� �������� �������� �������
  if ( allreq=="" )  { print; exit 0 }
 # ������ ��� ���������� ��������� �������
  for ( i=1; i<=NF; i++ )  { libs[$i]=1 }
 # ����� ���� ���������� NF ���������
  for ( i=1; i<=NF; i++ )  {
   # ������� ����������, ����� ������� ������ �� ������ ����.
    for (lib in libs)  {
      if ( libs[lib]!=1 )  continue;   # ���� �� �������, SUN awk !..
      cand=lib;
      for (order in orders)  {
        if ( orders[order]!=1 )  continue;   # ���� �� �������, SUN awk !..
        split ( order, a, "@" );
	if ( a[2]==lib )  {cand=""; break}
	}
      if ( cand!="" )  break;
      }
   # ���� ����� ���, ������ ���������� �������������.
    if ( cand=="" )
      { print ( "Unresolvable library order requirements: " allreq );  exit 1; }
   # ��������� ��������� ���������� � ������
    if ( res=="" )  {res=cand}  else {res=res" "cand}
   # ������� ����������� ���������� �� ��������� ������
    libs[cand]=0;   # ���� �� �������, SUN awk !..
   # ������� ��� ����������, ��� ��� ���������� ������ (��� ��� ���������)
    for (order in orders)  {
      if ( orders[order]!=1 )  continue;   # ���� �� �������, SUN awk !..
      split ( order, a, "@" );
      if ( a[1]==cand )  {orders[order]=0}
      }
    }
 # ���������� ������
  print ( res );
  exit 0;
}
