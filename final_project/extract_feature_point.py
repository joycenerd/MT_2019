import xml.etree.ElementTree as ET
import csv

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
    tree=ET.parse('src/morphing1_annotations/frame0.xml')
    root=tree.getroot()
    file=open("src/coordinates/example.csv","w")
    writer=csv.writer(file)
    for child in root:
        if(child.tag=="object"):
            for subchild in child:
                if(subchild.tag=="polygon"):
                    coordinate_parser(subchild,writer)

if __name__=="__main__":
    main()
                        



