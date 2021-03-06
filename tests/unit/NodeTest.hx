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

class NodeTest
{
    public function new() { }

    /**
     * b
     *   c { class: testElt2 } 
     *   d { class: testElt }
     *      d { class: testElt2 }
     *        a { id: elt1, class: testElt }
     *        [data]
     *      ""
     *      e {}
     *      "Test Cocktail Text Content"
     *      "* str 5 *"
     *      e {}
     *      [data]
     *      "* str 6 *"
     *      "Test Cocktail Text Content"
     *   "Test Cocktail Text Content 2"
     *   [data]
     */
    @Before
    public function setup():Void
    {
    	this.document = new Document();

    	this.elt = document.createElement("a");
    	elt.id = "elt1";
    	elt.className = "testElt";

    	this.elt2 = document.createElement("b");
    	this.elt3 = document.createElement("c");
    	elt3.className = "testElt2";
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

        this.c1 = document.createComment("my comment");
        this.df1 = document.createDocumentFragment();

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

    var c1 : Comment;
    var document : Document;
    var df1 : DocumentFragment;
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
    public function testNodeType()
    {
        Assert.isTrue(Node.ELEMENT_NODE == 1);
        Assert.isTrue(Node.ATTRIBUTE_NODE == 2);
        Assert.isTrue(Node.TEXT_NODE == 3);
        Assert.isTrue(Node.CDATA_SECTION_NODE == 4);
        Assert.isTrue(Node.ENTITY_REFERENCE_NODE == 5);
        Assert.isTrue(Node.ENTITY_NODE == 6);
        Assert.isTrue(Node.PROCESSING_INSTRUCTION_NODE == 7);
        Assert.isTrue(Node.COMMENT_NODE == 8);
        Assert.isTrue(Node.DOCUMENT_NODE == 9);
        Assert.isTrue(Node.DOCUMENT_TYPE_NODE == 10);
        Assert.isTrue(Node.DOCUMENT_FRAGMENT_NODE == 11);

        Assert.isTrue(elt2.nodeType == Node.ELEMENT_NODE);
        Assert.isTrue(text1.nodeType == Node.TEXT_NODE);
        Assert.isTrue(pi1.nodeType == Node.PROCESSING_INSTRUCTION_NODE);
        Assert.isTrue(c1.nodeType == Node.COMMENT_NODE);
        Assert.isTrue(document.nodeType == Node.DOCUMENT_NODE);
        Assert.isTrue(dt1.nodeType == Node.DOCUMENT_TYPE_NODE);
        Assert.isTrue(df1.nodeType == Node.DOCUMENT_FRAGMENT_NODE);
    }

    @Test
    public function testIsEqualNode()
    {
        // Elements
        Assert.isTrue(elt6.isEqualNode(elt7));
        Assert.isFalse(elt4.isEqualNode(elt5));

        // Processing Instructions
        Assert.isFalse(pi1.isEqualNode(pi2));
        Assert.isTrue(pi1.isEqualNode(pi3));

        // Document Types
        Assert.isFalse(dt1.isEqualNode(dt2));
        Assert.isTrue(dt1.isEqualNode(dt3));

        // Texts
        Assert.isFalse(text1.isEqualNode(text2));
        Assert.isTrue(text1.isEqualNode(text3));
    }

    @Test
    public function testContains()
    {
        Assert.isTrue(elt2.contains(elt2));
        Assert.isTrue(elt2.contains(elt4));
        Assert.isTrue(elt2.contains(pi3));
        Assert.isFalse(elt4.contains(elt3));
    }

    @Test
    public function testNormalize()
    {
        Assert.isTrue(elt4.childNodes.length == 9);

        elt4.normalize();

        Assert.isTrue(elt4.childNodes.length == 6);
        Assert.isFalse(elt4.contains(text4));
        Assert.isTrue(elt4.contains(text1));
        Assert.isFalse(elt4.contains(text5));
        Assert.isTrue(elt4.contains(text6));

        Assert.isTrue(text1.data == "Test Cocktail Text Content* str 5 *");
        Assert.isTrue(text6.data == "* str 6 *Test Cocktail Text Content");
    }
}
