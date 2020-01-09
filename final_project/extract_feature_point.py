import xml.etree.ElementTree as ET
import csv
import os

def coordinate_parser(start,writer):
    for child in start:
        if(child.tag=="pt"):
            for coordinate in child:
                if(coordinate.tag=="x"):
                    x=coordinate.text
                elif(coordinate.tag=="y"):
                    y=coordinate.text
            writer.writerow([x,y])



def main():
    path="src/morphing1_annotations/"
    for xml_file in os.listdir(path):
        xml_filepath=os.path.join(path,xml_file)
        tree=ET.parse(xml_filepath)
        root=tree.getroot()
        fname=xml_file[:-4]
        csv_file=open("src/coordinates/morphing1/"+fname+".csv","w")
        writer=csv.writer(csv_file)
        for child in root:
            if(child.tag=="object"):
                for subchild in child:
                    if(subchild.tag=="polygon"):
                        coordinate_parser(subchild,writer)
        csv_file.close()

    path="src/morphing2_annotations/"
    for xml_file in os.listdir(path):
        xml_filepath=os.path.join(path,xml_file)
        tree=ET.parse(xml_filepath)
        root=tree.getroot()
        fname=xml_file[:-4]
        csv_file=open("src/coordinates/morphing2/"+fname+".csv","w")
        writer=csv.writer(csv_file)
        for child in root:
            if(child.tag=="object"):
                for subchild in child:
                    if(subchild.tag=="polygon"):
                        coordinate_parser(subchild,writer)
        csv_file.close()

if __name__=="__main__":
    main()
                        



