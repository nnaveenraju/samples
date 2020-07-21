import ballerina/grpc;
import ballerina/system;

listener grpc:Listener ep = new (9090);

map<Person> personMap = {};

service AdminService on ep {

    resource function add(grpc:Caller caller, AddRequest value) returns error? {
        check caller->send(value.numbers.reduce(function (int n, int i) returns int => n + i, 0));
        check caller->complete();
    }

    resource function multiply(grpc:Caller caller, MultiplyRequest value) returns error? {
        check caller->send(value.v1 + value.v2);
        check caller->complete();
    }

    resource function addPerson(grpc:Caller caller, Person value) returns error? {
        value.id = system:uuid();
        personMap[value.id] = <@untainted> value;
        check caller->send(value.id);
        check caller->complete();
    }

    resource function getPerson(grpc:Caller caller, GetPersonRequest value) returns error? {
        check caller->send(personMap[value.id]);
        check caller->complete();
    }
    
}

public type AddRequest record {|
    int[] numbers = [];
    
|};

public type MultiplyResponse record {|
    int result = 0;
    
|};

public type GetPersonRequest record {|
    string id = "";
    
|};

public type AddResponse record {|
    int result = 0;
    
|};

public type AddPersonResponse record {|
    string id = "";
    
|};

public type Person record {|
    string id = "";
    string name = "";
    int birthYear = 0;
    
|};

public type MultiplyRequest record {|
    int v1 = 0;
    int v2 = 0;
    
|};



const string ROOT_DESCRIPTOR = "0A0B61646D696E2E70726F746F224A0A06506572736F6E120E0A0269641801200128095202696412120A046E616D6518022001280952046E616D65121C0A09626972746859656172180320012805520962697274685965617222220A10476574506572736F6E52657175657374120E0A0269641801200128095202696422230A11416464506572736F6E526573706F6E7365120E0A0269641801200128095202696422260A0A4164645265717565737412180A076E756D6265727318012003280352076E756D6265727322250A0B416464526573706F6E736512160A06726573756C741801200128035206726573756C7422310A0F4D756C7469706C7952657175657374120E0A02763118012001280352027631120E0A02763218022001280352027632222A0A104D756C7469706C79526573706F6E736512160A06726573756C741801200128035206726573756C7432B4010A0C41646D696E5365727669636512200A03616464120B2E416464526571756573741A0C2E416464526573706F6E7365122F0A086D756C7469706C7912102E4D756C7469706C79526571756573741A112E4D756C7469706C79526573706F6E736512280A09616464506572736F6E12072E506572736F6E1A122E416464506572736F6E526573706F6E736512270A09676574506572736F6E12112E476574506572736F6E526571756573741A072E506572736F6E620670726F746F33";
function getDescriptorMap() returns map<string> {
    return {
        "admin.proto":"0A0B61646D696E2E70726F746F224A0A06506572736F6E120E0A0269641801200128095202696412120A046E616D6518022001280952046E616D65121C0A09626972746859656172180320012805520962697274685965617222220A10476574506572736F6E52657175657374120E0A0269641801200128095202696422230A11416464506572736F6E526573706F6E7365120E0A0269641801200128095202696422260A0A4164645265717565737412180A076E756D6265727318012003280352076E756D6265727322250A0B416464526573706F6E736512160A06726573756C741801200128035206726573756C7422310A0F4D756C7469706C7952657175657374120E0A02763118012001280352027631120E0A02763218022001280352027632222A0A104D756C7469706C79526573706F6E736512160A06726573756C741801200128035206726573756C7432B4010A0C41646D696E5365727669636512200A03616464120B2E416464526571756573741A0C2E416464526573706F6E7365122F0A086D756C7469706C7912102E4D756C7469706C79526571756573741A112E4D756C7469706C79526573706F6E736512280A09616464506572736F6E12072E506572736F6E1A122E416464506572736F6E526573706F6E736512270A09676574506572736F6E12112E476574506572736F6E526571756573741A072E506572736F6E620670726F746F33"
        
    };
}
