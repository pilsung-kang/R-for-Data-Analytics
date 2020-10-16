# Part 1: XPath with XML -----------------------------------------
install.packages("XML")
library("XML")

# XML/HTML parsing
obamaurl <- "http://www.obamaspeeches.com/"
obamaroot <- htmlParse(obamaurl)
obamaroot

# Xpath example
xmlfile <- "xml_example.xml"
tmpxml <- xmlParse(xmlfile)
root <- xmlRoot(tmpxml)
root

# Select children node
xmlChildren(root)[[1]]

xmlChildren(xmlChildren(root)[[1]])[[1]]
xmlChildren(xmlChildren(root)[[1]])[[2]]
xmlChildren(xmlChildren(root)[[1]])[[3]]
xmlChildren(xmlChildren(root)[[1]])[[4]]

# Selecting nodes
xpathSApply(root, "/bookstore/book[1]")
xpathSApply(root, "/bookstore/book[last()]")
xpathSApply(root, "/bookstore/book[last()-1]")
xpathSApply(root, "/bookstore/book[position()<3]")

# Selecting attributes
xpathSApply(root, "//@category")
xpathSApply(root, "//@lang")
xpathSApply(root, "//book/title", xmlGetAttr, 'lang')

# Selecting atomic values
xpathSApply(root, "//title", xmlValue)
xpathSApply(root, "//title[@lang='en']", xmlValue)
xpathSApply(root, "//book[@category='web']/price", xmlValue)
xpathSApply(root, "//book[price > 35]/title", xmlValue)
xpathSApply(root, "//book[@category = 'web' and price > 40]/price", xmlValue)