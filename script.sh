#!/bin/bash
cd keebs/
for img in *; do
    if [ $img != 'thumbs' ]
    then
      IFS=' ' read -ra IDEN <<< $(identify $img)
      IFS='x' read -ra DIMS <<< "${IDEN[2]}"
      if [ ${DIMS[0]} -gt ${DIMS[1]} ]
      then
        convert -thumbnail x350 $img ./thumbs/${img%.*}_thumbs.jpg
      else
        convert -thumbnail 350 $img ./thumbs/${img%.*}_thumbs.jpg
      fi
    fi
done

cd ../
echo -n > index.html
cat header.html >> index.html
echo "    <h1><a href=\"../index.html\">images</a></h1>" >> index.html
echo "    <div class=\"images\">" >> index.html
for img in *; do
  if [ $img != 'index.html' ] && [ $img != 'thumbs' ]
  then
    echo "      <a href=\"./keebs/$img\" style='background-image: url(\"./keebs/thumbs/${img%.*}_thumbs.jpg\");' alt=\"${img%.*}\"></a>" >> index.html
  fi
done
echo "    </div>" >> index.html
echo "  </body>" >> index.html
echo "</html>" >> index.html
