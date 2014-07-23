package ;

import cocktail.dom.Attr;
import cocktail.dom.CharacterData;
import cocktail.dom.Comment;
import cocktail.dom.Document;
import cocktail.dom.DocumentFragment;
import cocktail.dom.DocumentType;
import cocktail.dom.DOMConstants;
import cocktail.dom.DOMException;
import cocktail.dom.DOMImplementation;
import cocktail.dom.DOMSettableTokenList;
import cocktail.dom.DOMTokenList;
import cocktail.dom.DOMTools;
import cocktail.dom.Element;
import cocktail.dom.HTMLCollection;
import cocktail.dom.Node;
import cocktail.dom.NodeList;
import cocktail.dom.ProcessingInstruction;
import cocktail.dom.Text;

import massive.munit.Assert;

class ElementTest
{
    public function new() { }

    @Before
    public function setup():Void
    {
    	this.document = new Document();

    	this.elt = document.createElement("a");
    	elt.id = "elt1";
    	elt.className = "testElt";

    	this.elt2 = document.createElement("b");
    	this.elt3 = document.createElement("c");
    	elt3.className = "testElt2 class1 classn";
    	this.elt4 = document.createElement("d");
    	elt4.className = "testElt";
    	this.elt5 = document.createElement("d");
    	elt5.className = "testElt2";
        this.elt6 = document.createElement("e");
    	this.elt7 = document.createElement("e");
        this.text1 = document.createTextNode("Test Cocktail Text Content");
        this.text2 = document.createTextNode("Test Cocktail Text Content 2");
        this.text3 = document.createTextNode("Test Cocktail Text Content");
        this.text4 = document.createTextNode("");
        this.text5 = document.createTextNode("* str 5 *");
        this.text6 = document.createTextNode("* str 6 *");
        this.pi1 = document.createProcessingInstruction("target", "data");
        this.pi2 = document.createProcessingInstruction("target1", "data");
        this.pi3 = document.createProcessingInstruction("target", "data");

        this.dt1 = document.implementation.createDocumentType("str1", "str2", "str3");
        this.dt2 = document.implementation.createDocumentType("str10", "str20", "str30");
        this.dt3 = document.implementation.createDocumentType("str1", "str2", "str3");

    	document.appendChild(elt2);
    	elt2.appendChild(elt3);
        elt2.appendChild(elt4);
    	elt2.appendChild(text2);

        elt4.appendChild(elt5);
    	elt4.appendChild(text4);
        elt4.appendChild(elt6);
        elt4.appendChild(text1);
        elt4.appendChild(text5);
    	elt4.appendChild(elt7);
    	elt4.appendChild(pi2);
        elt4.appendChild(text6);
        elt4.appendChild(text3);

        elt5.appendChild(elt);
        elt5.appendChild(pi3);
        elt2.appendChild(pi1);
    }

    var document : Document;
    var dt1 : DocumentType;
    var dt2 : DocumentType;
    var dt3 : DocumentType;
    var elt : Element;
    var elt2 : Element;
    var elt3 : Element;
    var elt4 : Element;
    var elt5 : Element;
    var elt6 : Element;
    var elt7 : Element;
    var pi1 : ProcessingInstruction;
    var pi2 : ProcessingInstruction;
    var pi3 : ProcessingInstruction;
    var text1 : Text;
    var text2 : Text;
    var text3 : Text;
    var text4 : Text;
    var text5 : Text;
    var text6 : Text;

    @Test
    public function testLocalName()
    {
        Assert.isTrue(elt.localName == "a");
        Assert.isTrue(elt2.localName == "b");
    }

    @Test
    public function testTagName()
    {
        Assert.isTrue(elt.localName.toUpperCase() == elt.tagName);
        Assert.isTrue(elt3.localName.toUpperCase() == elt3.tagName);
    }

    @Test
    public function testElementSiblings()
    {
        Assert.isTrue(elt4.previousElementSibling == elt3);
        Assert.isNull(elt4.nextElementSibling);
        Assert.isNull(elt5.previousElementSibling);
        Assert.isTrue(elt5.nextElementSibling == elt6);
    }

    @Test
    public function testId()
    {
        Assert.isTrue(elt.id == "elt1");
        Assert.isTrue(elt4.id == "");
    }

    @Test
    public function testClassNameAndClassList()
    {
        Assert.isTrue(elt.className == "testElt");
        Assert.isTrue(elt3.className == "testElt2 class1 classn");
        Assert.isTrue(elt7.className == "");

        Assert.isTrue(elt.classList.contains("testElt"));
        Assert.isTrue(elt3.classList.contains("testElt2"));
        Assert.isTrue(elt3.classList.contains("class1"));
        Assert.isTrue(elt3.classList.contains("classn"));
        Assert.isTrue(elt3.classList.item(2) == "classn");
        Assert.isTrue(elt3.classList.item(0) == "testElt2");

        elt.classList.add("testElt3");
        Assert.isTrue(elt.classList.contains("testElt"));
        Assert.isTrue(elt.classList.contains("testElt3"));
        Assert.isTrue(elt.className == "testElt testElt3");

        elt.classList.add("testElt4", "testElt6");
        Assert.isTrue(elt.classList.contains("testElt"));
        Assert.isTrue(elt.classList.contains("testElt3"));
        Assert.isTrue(elt.classList.contains("testElt4"));
        Assert.isTrue(elt.classList.contains("testElt6"));
        Assert.isTrue(elt.className == "testElt testElt3 testElt4 testElt6");

        elt.classList.remove("testElt3");
        Assert.isTrue(elt.classList.contains("testElt"));
        Assert.isFalse(elt.classList.contains("testElt3"));
        Assert.isTrue(elt.classList.contains("testElt4"));
        Assert.isTrue(elt.classList.contains("testElt6"));
        Assert.isTrue(elt.className == "testElt testElt4 testElt6");

        elt.classList.toggle("testElt");
        Assert.isFalse(elt.classList.contains("testElt"));
        Assert.isTrue(elt.classList.contains("testElt4"));
        Assert.isTrue(elt.classList.contains("testElt6"));
        Assert.isTrue(elt.className == "testElt4 testElt6");
    }

    @Test
    public function testMatches()
    {
        Assert.isTrue(elt2.matches('b'));
        Assert.isFalse(elt2.matches('a'));
        Assert.isFalse(elt2.matches('.a'));

        Assert.isTrue(elt3.matches('c'));
        Assert.isTrue(elt3.matches('.testElt2'));
        Assert.isTrue(elt3.matches('.class1'));
        Assert.isTrue(elt3.matches('.classn'));
        Assert.isTrue(elt3.matches('.testElt2.class1'));
        Assert.isTrue(elt3.matches('.class1.classn'));
        Assert.isTrue(elt3.matches('.testElt2.classn'));
        Assert.isTrue(elt3.matches('.testElt2.class1.classn'));
        Assert.isFalse(elt3.matches('.testElt2.class1.class2'));
        Assert.isFalse(elt3.matches('.class2'));
    }


    /* Add tests for :
    attributes, children, firstElementChild, lastElementChild, childElementCount
    */
}
