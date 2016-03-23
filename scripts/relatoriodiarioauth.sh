#!/bin/bash
DATA=`date +%Y%m%d -d "1 days ago" `
DATA2=`date +%B -d "1 days ago"`
DATA3=`date +%d-%m-%Y -d "1 days ago" `
DATA4=`date +%d -d "1 days ago"`
DATA5=`date +%d -d "2 days ago"`
ARQ1="$DATA-1.png"
ARQ2="$DATA-2.png"
ARQ3="$DATA-3.png"
ARQ4="$DATA-4.png"
HTMLPATH=/var/www
CAMIN=/usr/VMS/gerargraficos
TOTALPNG=`ls *.png |wc -l |sed 's/ //g'`;
TOTALPNG1=`ls *.png `;
HTMLPATH=/var/www
CAMIN=/usr/VMS/gerargraficos

cd $CAMIN

for ((i=1; i <= $TOTALPNG; i++))
      do
ARQPNG="$DATA-$i.png"
cp $ARQPNG $HTMLPATH\/datas\/dias\/images
done

cd $HTMLPATH

CHECA=$(cat index.html |grep $DATA2 |wc -l)

if [ $CHECA == 0 ]; then
#Alimentando o index.html

    sed "s/<\/select>/<option value=\"http:\/\/10.178.41.150\/datas\/$DATA2.html\">$DATA2 <\/select>/g" index.html >index2.html

    mv index2.html index.html

#Criando a pagina do mes
 cd $HTMLPATH\/datas

    touch $DATA2.html

echo "
<html>
<head>
<link rel=Edit-Time-Data href=20140801>
<title>Levantamento diario de Autenticacao PCS</title>
<body>
<script language="JavaScript">
 function vai(combo)
 {
  var x = combo.selectedIndex;
  var endereco = combo.options[x].value;
  if (endereco != "#")
{
  novapagina = window.open(endereco,"NovaPgn");
}
}
</script>
<style>

<style>
    #nav ul {
        margin: 0;
        margin-top: 20px;
        padding: 0;
        list-style-type: none;
    }
    #nav ul li {
        display: inline;
    }
    #nav ul li a {
        text-decoration: none;
        padding: 0.2em 2em;
        color: #fff;
        background-color: #036;
    }
    #nav ul li a:hover {
        color: #fff;
        background-color: #369;
    }
    img{
        text-align: center;
        margin-top: 0px;
        margin-bottom: 90px;
    }
    .normal {
        margin: 0;
        font-family: Verdana;
    }
    #toppointer {
        margin-top:0
        display: inline;
        font-size: 8pt;
    }
</style>
<div class=normal>
<center><img src=images/logo-2011.jpg></center>
<center><h2>DIAS</h2></center>
<BR>
<font face=verdana,tahoma,arial size=2><center>Dias analisados: </center></font>
<div align=center id=nav>
<ul>
<form name="Menu">
 <select name="pages" size="1" onChange=\"vai\(this\)\;\">
  <option value="#">Qual dia voce quer pesquisar?
</select>
</form>
</ul>
</div>

<div class=normal>
<div align=right id=voltar>
<a href="http://10.178.41.150"> Voltar </a>
</div>
" > "$DATA2.html"


    #sed "s/<\/ul>/<a href=\"http\:\/\/10.178.41.150\/datas\/dias\/$DATA3.html\" >$DATA3<\/a> <\/ul>/g" $DATA2.html > temp.html
    sed "s/>$DATA5/>$DATA5 <option value=\"http\:\/\/10.178.41.150\/datas\/dias\/$DATA3.html\" >$DATA4/g" $DATA2.html > temp.html

    mv temp.html $DATA2.html

else
    cd $HTMLPATH\/datas
    #alimentando a pagina do mes
    sed "s/>$DATA5/>$DATA5 <option value=\"http\:\/\/10.178.41.150\/datas\/dias\/$DATA3.html\" >$DATA4/g" $DATA2.html > temp.html

    mv temp.html $DATA2.html
fi

#Criando as paginas de datas e alimentado

cd $HTMLPATH\/datas\/dias

touch $DATA3.html
echo "
<div align=center id=nav>">> "$DATA3.html"

for ((i=1; i <= $TOTALPNG; i++))
      do
ARQPNG="$DATA-$i.png"    
echo "
<img src=\"images/$ARQPNG\" alt=\"teste\">
" >> "$DATA3.html"

done

echo "
</div>
<div class=\"normal\">
<div align=\"right\" id=\"voltar\">
<a href=\"http://10.178.41.150/datas/$DATA2.html\"> Voltar </a>
</div>" >> "$DATA3.html"


#rm /usr/VMS/gerargraficos/*.png