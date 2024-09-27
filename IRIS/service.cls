Class Vec.Web.service Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

Parameter CONTENTTYPE = "application/json";

Parameter UseSession = 0;

/// By default convert the input stream to Unicode
Parameter CONVERTINPUTSTREAM = 1;

/// Sets the response charset to utf-8
Parameter CHARSET = "utf-8";

XData UrlMap [ XMLNamespace = "https://www.intersystems.com/urlmap" ]
{
<Routes>
    <Route Url="/test" Method="GET" Call="Test"/>
	<Route Url="/check" Method="POST" Call="Check" />
	<Route Url="/checkall" Method="POST" Call="CheckAll" />
	<Route Url="/save" Method="POST" Call="Save" />
	<Route Url="/savefull" Method="POST" Call="SaveFull" />
	<Route Url="/saveml" Method="POST" Call="SaveML" />
</Routes>
}

/// Tester method
ClassMethod Test() As %Status
{
	Set cm = {
		"Funciona": "SI"
	}
	//Write cm.%ToJSON()
    Do ##class(%REST.Impl).%WriteResponse(cm.%ToJSON())
	quit $$$OK
}

ClassMethod Save() As %Status
{
    Try {
        set respuesta=""
       Do ##class(%REST.Impl).%SetContentType("application/json")
        // Reading the body of the http call with the person data
        set dynamicBody = {}.%FromJSON(%request.Content)

        Set vector = ""

        set array = []

        set vectorDinamico = dynamicBody.arreglo 
        set iter = vectorDinamico.%GetIterator()
        while iter.%GetNext(.key, .value) {

             do array.%Set(key,value."_x"_","_value."_y")
             set vector=vector_value."_x"_","_value."_y"
             if (key < 67) {set vector=vector_","}
        }
        
        s ^zMBN($zn,$j,"vectorDinamico")=$REPLACE(vectorDinamico.%ToJSON(),"'","")

        s ^zMBN($zn,$j,"array.%Get(67)")=array.%Get(67)
        &sql(INSERT INTO Vec.Person ( name, pass, photo) VALUES (:dynamicBody.name, :dynamicBody.pass, TO_VECTOR(:vector, DECIMAL)))
        
        if (SQLCODE '= 0) {
        write !, "Insert or update failed, SQLCODE= ", SQLCODE, ! ,%msg
        quit
        }
        Do ##class(%REST.Impl).%SetStatusCode("200")
        Do ##class(%REST.Impl).%WriteResponse({"result": "Registro Ingresado"}.%ToJSON())
        
    } Catch (ex) {
        Do ##class(%REST.Impl).%SetStatusCode("400")
        Do ##class(%REST.Impl).%WriteResponse(ex.DisplayString())
        return {"errormessage": "Client error"}
    }
    Quit $$$OK
}

ClassMethod SaveFull() As %Status
{
    Try {
        set respuesta=""
       Do ##class(%REST.Impl).%SetContentType("application/json")
        // Reading the body of the http call with the person data
        set dynamicBody = {}.%FromJSON(%request.Content)

        Set vector = ""

        set array = []

        set vectorDinamico = dynamicBody.arreglo 
        set iter = vectorDinamico.%GetIterator()
        while iter.%GetNext(.key, .value) {

             do array.%Set(key,value."_x"_","_value."_y")
             set vector=vector_value."_x"_","_value."_y"
             if (key < 67) {set vector=vector_","}
        }
        
       
        &sql(INSERT INTO Vec.PersonFull(name, pass, vec1, vec2, vec3, vec4, vec5, vec6, vec7, vec8, vec9, vec10, vec11, vec12, vec13, vec14, vec15, vec16, vec17, vec18, vec19, vec20, vec21, vec22, vec23, vec24, vec25, vec26, vec27, vec28, vec29, vec30, vec31, vec32, vec33, vec34, vec35, vec36, vec37, vec38, vec39, vec40, vec41, vec42, vec43, vec44, vec45, vec46, vec47, vec48, vec49, vec50, vec51, vec52, vec53, vec54, vec55, vec56, vec57, vec58, vec59, vec60, vec61, vec62, vec63, vec64, vec65, vec66, vec67, vec68)VALUES (:dynamicBody.name, :dynamicBody.pass, TO_VECTOR(:array.%Get(0), DECIMAL), TO_VECTOR(:array.%Get(1), DECIMAL), TO_VECTOR(:array.%Get(2), DECIMAL), TO_VECTOR(:array.%Get(3), DECIMAL), TO_VECTOR(:array.%Get(4), DECIMAL), TO_VECTOR(:array.%Get(5), DECIMAL), TO_VECTOR(:array.%Get(6), DECIMAL), TO_VECTOR(:array.%Get(7), DECIMAL), TO_VECTOR(:array.%Get(8), DECIMAL), TO_VECTOR(:array.%Get(9), DECIMAL), TO_VECTOR(:array.%Get(10), DECIMAL), TO_VECTOR(:array.%Get(11), DECIMAL), TO_VECTOR(:array.%Get(12), DECIMAL), TO_VECTOR(:array.%Get(13), DECIMAL), TO_VECTOR(:array.%Get(14), DECIMAL), TO_VECTOR(:array.%Get(15), DECIMAL), TO_VECTOR(:array.%Get(16), DECIMAL), TO_VECTOR(:array.%Get(17), DECIMAL), TO_VECTOR(:array.%Get(18), DECIMAL), TO_VECTOR(:array.%Get(19), DECIMAL), TO_VECTOR(:array.%Get(20), DECIMAL), TO_VECTOR(:array.%Get(21), DECIMAL), TO_VECTOR(:array.%Get(22), DECIMAL), TO_VECTOR(:array.%Get(23), DECIMAL), TO_VECTOR(:array.%Get(24), DECIMAL), TO_VECTOR(:array.%Get(25), DECIMAL), TO_VECTOR(:array.%Get(26), DECIMAL), TO_VECTOR(:array.%Get(27), DECIMAL), TO_VECTOR(:array.%Get(28), DECIMAL), TO_VECTOR(:array.%Get(29), DECIMAL), TO_VECTOR(:array.%Get(30), DECIMAL), TO_VECTOR(:array.%Get(31), DECIMAL), TO_VECTOR(:array.%Get(32), DECIMAL), TO_VECTOR(:array.%Get(33), DECIMAL), TO_VECTOR(:array.%Get(34), DECIMAL), TO_VECTOR(:array.%Get(35), DECIMAL), TO_VECTOR(:array.%Get(36), DECIMAL), TO_VECTOR(:array.%Get(37), DECIMAL), TO_VECTOR(:array.%Get(38), DECIMAL), TO_VECTOR(:array.%Get(39), DECIMAL), TO_VECTOR(:array.%Get(40), DECIMAL), TO_VECTOR(:array.%Get(41), DECIMAL), TO_VECTOR(:array.%Get(42), DECIMAL), TO_VECTOR(:array.%Get(43), DECIMAL), TO_VECTOR(:array.%Get(44), DECIMAL), TO_VECTOR(:array.%Get(45), DECIMAL), TO_VECTOR(:array.%Get(46), DECIMAL), TO_VECTOR(:array.%Get(47), DECIMAL), TO_VECTOR(:array.%Get(48), DECIMAL), TO_VECTOR(:array.%Get(49), DECIMAL), TO_VECTOR(:array.%Get(50), DECIMAL), TO_VECTOR(:array.%Get(51), DECIMAL), TO_VECTOR(:array.%Get(52), DECIMAL), TO_VECTOR(:array.%Get(53), DECIMAL), TO_VECTOR(:array.%Get(54), DECIMAL), TO_VECTOR(:array.%Get(55), DECIMAL), TO_VECTOR(:array.%Get(56), DECIMAL), TO_VECTOR(:array.%Get(57), DECIMAL), TO_VECTOR(:array.%Get(58), DECIMAL), TO_VECTOR(:array.%Get(59), DECIMAL), TO_VECTOR(:array.%Get(60), DECIMAL), TO_VECTOR(:array.%Get(61), DECIMAL), TO_VECTOR(:array.%Get(62), DECIMAL), TO_VECTOR(:array.%Get(63), DECIMAL), TO_VECTOR(:array.%Get(64), DECIMAL), TO_VECTOR(:array.%Get(65), DECIMAL), TO_VECTOR(:array.%Get(66), DECIMAL), TO_VECTOR(:array.%Get(67), DECIMAL)))
        

        if (SQLCODE '= 0) {
        write !, "Insert or update failed, SQLCODE= ", SQLCODE, ! ,%msg
        quit
        }
        Do ##class(%REST.Impl).%SetStatusCode("200")
        Do ##class(%REST.Impl).%WriteResponse({"result": "Registro Ingresado"}.%ToJSON())
        
    } Catch (ex) {
        Do ##class(%REST.Impl).%SetStatusCode("400")
        Do ##class(%REST.Impl).%WriteResponse(ex.DisplayString())
        write {"errormessage": "Client error"}.%ToJSON()
    }
    Quit $$$OK
}

ClassMethod SaveML() As %Status
{
    Try {
        set respuesta=""
       Do ##class(%REST.Impl).%SetContentType("application/json")
        // Reading the body of the http call with the person data
        set dynamicBody = {}.%FromJSON(%request.Content)

        Set vector1 = ""
        set vectorDinamico1 = dynamicBody.arreglo1 
        set iter1 = vectorDinamico1.%GetIterator()
        while iter1.%GetNext(.key, .value) {
             set vector1=vector1_value."_x"_","_value."_y"
             if (key < 67) {set vector1=vector1_","}
        }
        
        s ^zMBN($zn,$j,"vectorDinamico1")=$REPLACE(vectorDinamico1.%ToJSON(),"'","")
        set vectorJSON=vectorDinamico1.%ToJSON()
        &sql(INSERT INTO Vec.PersonML ( name, pass, photo) VALUES (:dynamicBody.name, :dynamicBody.pass, TO_VECTOR(:vector1, DECIMAL)))
        //&sql(TRAIN MODEL MODELPersonML USING {:vectorJSON})
        
        //&sql(INSERT INTO Vec.PersonCompleta(name, description, vec1, vec2, vec3, vec4, vec5, vec6, vec7, vec8, vec9, vec10, vec11, vec12, vec13, vec14, vec15, vec16, vec17, vec18, vec19, vec20, vec21, vec22, vec23, vec24, vec25, vec26, vec27, vec28, vec29, vec30, vec31, vec32, vec33, vec34, vec35, vec36, vec37, vec38, vec39, vec40, vec41, vec42, vec43, vec44, vec45, vec46, vec47, vec48, vec49, vec50, vec51, vec52, vec53, vec54, vec55, vec56, vec57, vec58, vec59, vec60, vec61, vec62, vec63, vec64, vec65, vec66, vec67, vec68)VALUES (:dynamicBody.name, :vectorDinamico.%ToJSON(), TO_VECTOR(:array.%Get(0), DECIMAL), TO_VECTOR(:array.%Get(1), DECIMAL), TO_VECTOR(:array.%Get(2), DECIMAL), TO_VECTOR(:array.%Get(3), DECIMAL), TO_VECTOR(:array.%Get(4), DECIMAL), TO_VECTOR(:array.%Get(5), DECIMAL), TO_VECTOR(:array.%Get(6), DECIMAL), TO_VECTOR(:array.%Get(7), DECIMAL), TO_VECTOR(:array.%Get(8), DECIMAL), TO_VECTOR(:array.%Get(9), DECIMAL), TO_VECTOR(:array.%Get(10), DECIMAL), TO_VECTOR(:array.%Get(11), DECIMAL), TO_VECTOR(:array.%Get(12), DECIMAL), TO_VECTOR(:array.%Get(13), DECIMAL), TO_VECTOR(:array.%Get(14), DECIMAL), TO_VECTOR(:array.%Get(15), DECIMAL), TO_VECTOR(:array.%Get(16), DECIMAL), TO_VECTOR(:array.%Get(17), DECIMAL), TO_VECTOR(:array.%Get(18), DECIMAL), TO_VECTOR(:array.%Get(19), DECIMAL), TO_VECTOR(:array.%Get(20), DECIMAL), TO_VECTOR(:array.%Get(21), DECIMAL), TO_VECTOR(:array.%Get(22), DECIMAL), TO_VECTOR(:array.%Get(23), DECIMAL), TO_VECTOR(:array.%Get(24), DECIMAL), TO_VECTOR(:array.%Get(25), DECIMAL), TO_VECTOR(:array.%Get(26), DECIMAL), TO_VECTOR(:array.%Get(27), DECIMAL), TO_VECTOR(:array.%Get(28), DECIMAL), TO_VECTOR(:array.%Get(29), DECIMAL), TO_VECTOR(:array.%Get(30), DECIMAL), TO_VECTOR(:array.%Get(31), DECIMAL), TO_VECTOR(:array.%Get(32), DECIMAL), TO_VECTOR(:array.%Get(33), DECIMAL), TO_VECTOR(:array.%Get(34), DECIMAL), TO_VECTOR(:array.%Get(35), DECIMAL), TO_VECTOR(:array.%Get(36), DECIMAL), TO_VECTOR(:array.%Get(37), DECIMAL), TO_VECTOR(:array.%Get(38), DECIMAL), TO_VECTOR(:array.%Get(39), DECIMAL), TO_VECTOR(:array.%Get(40), DECIMAL), TO_VECTOR(:array.%Get(41), DECIMAL), TO_VECTOR(:array.%Get(42), DECIMAL), TO_VECTOR(:array.%Get(43), DECIMAL), TO_VECTOR(:array.%Get(44), DECIMAL), TO_VECTOR(:array.%Get(45), DECIMAL), TO_VECTOR(:array.%Get(46), DECIMAL), TO_VECTOR(:array.%Get(47), DECIMAL), TO_VECTOR(:array.%Get(48), DECIMAL), TO_VECTOR(:array.%Get(49), DECIMAL), TO_VECTOR(:array.%Get(50), DECIMAL), TO_VECTOR(:array.%Get(51), DECIMAL), TO_VECTOR(:array.%Get(52), DECIMAL), TO_VECTOR(:array.%Get(53), DECIMAL), TO_VECTOR(:array.%Get(54), DECIMAL), TO_VECTOR(:array.%Get(55), DECIMAL), TO_VECTOR(:array.%Get(56), DECIMAL), TO_VECTOR(:array.%Get(57), DECIMAL), TO_VECTOR(:array.%Get(58), DECIMAL), TO_VECTOR(:array.%Get(59), DECIMAL), TO_VECTOR(:array.%Get(60), DECIMAL), TO_VECTOR(:array.%Get(61), DECIMAL), TO_VECTOR(:array.%Get(62), DECIMAL), TO_VECTOR(:array.%Get(63), DECIMAL), TO_VECTOR(:array.%Get(64), DECIMAL), TO_VECTOR(:array.%Get(65), DECIMAL), TO_VECTOR(:array.%Get(66), DECIMAL), TO_VECTOR(:array.%Get(67), DECIMAL)))
        

        if (SQLCODE '= 0) {
        write !, "Insert or update failed, SQLCODE= ", SQLCODE, ! ,%msg
        quit
        }
        Do ##class(%REST.Impl).%SetStatusCode("200")
        Do ##class(%REST.Impl).%WriteResponse({"result": "Registro Ingresado"}.%ToJSON())
        
    } Catch (ex) {
        Do ##class(%REST.Impl).%SetStatusCode("400")
        Do ##class(%REST.Impl).%WriteResponse(ex.DisplayString())
        return {"errormessage": "Client error"}
    }
    Quit $$$OK
}

ClassMethod Check() As %Status
{
    Try {
        Do ##class(%REST.Impl).%SetContentType("application/json")
 
        // Reading the body of the http call with the person data
        Set dynamicBody = {}.%FromJSON(%request.Content)
        //s ^zMBN($zn,$j,"dynamicBody")=dynamicBody.toString()

        Set vector = ""

        set array = []

        set vectorDinamico = dynamicBody

        set iter = vectorDinamico.%GetIterator()
        while iter.%GetNext(.key, .value) {
            s ^zMBN($zn,$j,"tam")=key
             do array.%Set(key,value."_x"_","_value."_y")
             set vector=vector_value."_x"_","_value."_y"
             if (key < 67) {set vector=vector_","}
        }
        
       // s ^zMBN($zn,$j,"vectro")=vector

        set name=""
        set pass=""

        &sql(SELECT top 1 name, pass into :name,:pass FROM Vec.Personfull emb 
        ORDER BY VECTOR_COSINE(vec1 , TO_VECTOR(:array.%Get(0),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(1),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(2),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(3),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(4),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(5),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(6),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(7),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(8),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(9),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(10),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(11),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(12),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(13),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(14),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(15),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(16),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(17),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(18),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(19),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(20),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(21),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(22),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(23),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(24),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(25),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(26),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(27),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(28),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(29),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(30),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(31),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(32),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(33),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(34),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(35),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(36),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(37),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(38),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(39),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(40),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(41),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(42),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(43),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(44),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(45),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(46),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(47),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(48),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(49),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(50),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(51),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(52),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(53),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(54),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(55),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(56),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(57),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(58),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(59),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(60),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(61),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(62),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(63),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(64),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(65),DECIMAL)) DESC, VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(66),DECIMAL)) DESC,
        VECTOR_COSINE(vec2 , TO_VECTOR(:array.%Get(67),DECIMAL)) DESC)
        

        //&sql(SELECT name, description into :name,:description FROM Vec.Person emb ORDER BY VECTOR_COSINE(emb.photo , TO_VECTOR(:vector,DECIMAL)) DESC )

        //&sql(SELECT name, description into :name,:description FROM Vec.Person emb ORDER BY VECTOR_COSINE(emb.photo , TO_VECTOR(:vector,DECIMAL)) DESC )

        set result = {"name": "", "pass":""}
        set result.name = name
        set result.pass = pass

        s ^zMBN($zn,$j,"datos")=result.%ToJSON()
        Do ##class(%REST.Impl).%WriteResponse(result.%ToJSON())
        //write source result.%ToJSON()
        Do ##class(%REST.Impl).%SetContentType("application/json")
        Do ##class(%REST.Impl).%SetStatusCode("200")	
        
       
        
    } Catch (ex) {
        Do ##class(%REST.Impl).%SetStatusCode("400")
        s ^zMBN($zn,$j,"ERROR")=ex.DisplayString()
        return ex.DisplayString()
    }
    Quit $$$OK
}

ClassMethod CheckAll() As %Status
{
    Try {
        Do ##class(%REST.Impl).%SetContentType("application/json")
 
        // Reading the body of the http call with the person data
        Set dynamicBody = {}.%FromJSON(%request.Content)
        //s ^zMBN($zn,$j,"dynamicBody")=dynamicBody.toString()

        Set vector = ""

        set array = []

        set vectorDinamico = dynamicBody

        set iter = vectorDinamico.%GetIterator()
        while iter.%GetNext(.key, .value) {
            s ^zMBN($zn,$j,"tam")=key
             do array.%Set(key,value."_x"_","_value."_y")
             set vector=vector_value."_x"_","_value."_y"
             if (key < 67) {set vector=vector_","}
        }
        
       // s ^zMBN($zn,$j,"vectro")=vector

        set name=""
        set pass=""

        &sql(SELECT name, pass into :name,:pass FROM Vec.Person emb ORDER BY VECTOR_COSINE(emb.photo , TO_VECTOR(:vector,DECIMAL)) DESC )

        //&sql(SELECT name, description into :name,:description FROM Vec.Person emb ORDER BY VECTOR_COSINE(emb.photo , TO_VECTOR(:vector,DECIMAL)) DESC )

        set result = {"name": "", "pass":""}
        set result.name = name
        set result.pass = pass

        s ^zMBN($zn,$j,"datos")=result.%ToJSON()
        Do ##class(%REST.Impl).%WriteResponse(result.%ToJSON())
        //write source result.%ToJSON()
        Do ##class(%REST.Impl).%SetContentType("application/json")
        Do ##class(%REST.Impl).%SetStatusCode("200")	
        
       
        
    } Catch (ex) {
        Do ##class(%REST.Impl).%SetStatusCode("400")
        s ^zMBN($zn,$j,"ERROR")=ex.DisplayString()
        return ex.DisplayString()
    }
    Quit $$$OK
}

}
