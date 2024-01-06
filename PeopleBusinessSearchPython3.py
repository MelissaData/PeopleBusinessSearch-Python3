import json
from threading import local
import requests
import argparse
import urllib.parse

def main():
  base_service_url = "https://search.melissadata.net/"
  service_endpoint = "v5/web/contactsearch/docontactSearch"

  # Create an ArgumentParser object
  parser = argparse.ArgumentParser(description='Smart Mover command line arguments parser')

  # Define the command line arguments
  parser.add_argument('--license', '-l', type=str, help='License key')
  parser.add_argument('--maxrecords', type=str, help='Max Records')
  parser.add_argument('--matchlevel', type=str, help='Match Level')
  parser.add_argument('--addressline1', type=str, help='Address Line 1')
  parser.add_argument('--locality', type=str, help='Locality')
  parser.add_argument('--administrativearea', type=str, help='Administrative Area')
  parser.add_argument('--postal', type=str, help='Postal Code')
  parser.add_argument('--anyname', type=str, help='Any Name')

  # Parse the command line arguments
  args = parser.parse_args()

  # Access the values of the command line arguments
  license = args.license
  maxrecords = args.maxrecords
  matchlevel = args.matchlevel
  addressline1 = args.addressline1
  locality = args.locality
  administrativearea = args.administrativearea
  postal = args.postal
  anyname = args.anyname

  call_api(base_service_url, service_endpoint, license, maxrecords, matchlevel, addressline1, locality, administrativearea, postal, anyname)

def get_contents(base_service_url, request_query):
    url = urllib.parse.urljoin(base_service_url, request_query)
    response = requests.get(url)
    obj = json.loads(response.text)
    pretty_response = json.dumps(obj, indent=4)

    print("\n================================== OUTPUT ==================================\n")

    print("API Call: ")
    for i in range(0, len(url), 70):
        if i + 70 < len(url):
            print(url[i:i+70])
        else:
            print(url[i:len(url)])
    print("\nAPI Response:")
    print(pretty_response)

def call_api(base_service_url, service_endpoint, license, maxrecords, matchlevel, addressline1, locality, administrativearea, postal, anyname):
    print("\n================= WELCOME TO MELISSA PEOPLE BUSINESS SEARCH CLOUD API =================\n")

    should_continue_running = True
    while should_continue_running:
        input_max_records = ""
        input_match_level = ""
        input_addressline1 = ""
        input_locality = ""
        input_administrativearea = ""
        input_postal = ""
        input_any_name = ""
        if not maxrecords and not matchlevel and not addressline1 and not locality and not administrativearea and not postal and not anyname:
            print("\nFill in each value to see results")
            input_max_records = input("Max Records: ")
            input_match_level = input("Match Level: ")
            input_addressline1 = input("Addressline1: ")
            input_locality = input("Locality: ")
            input_administrativearea = input("Administrative Area: ")
            input_postal = input("Postal: ")
            input_any_name = input("Any Name: ")
        else:
            input_max_records = maxrecords
            input_match_level = matchlevel
            input_addressline1 = addressline1
            input_locality = locality
            input_administrativearea = administrativearea
            input_postal = postal
            input_any_name = anyname

        while not input_max_records or not input_match_level or not input_addressline1 or not input_locality or not input_administrativearea or not input_postal or not input_any_name:
            print("\nFill in each value to see results")
            if not input_max_records:
                input_max_records = input("\nMax Records: ")
            if not input_match_level:
                input_match_level = input("\nMatch Level: ")
            if not input_addressline1:
                input_addressline1 = input("\nAddressline1: ")
            if not input_locality:
                input_locality = input("\nLocality: ")
            if not input_administrativearea:
                input_administrativearea = input("\nAdministrative Area: ")
            if not input_postal:
                input_postal = input("\nPostal: ")
            if not input_any_name:
                input_any_name = input("\nAny Name: ")

        inputs = {
            "format": "json",
            "maxrecords": input_max_records,
            "matchlevel": input_match_level,
            "a1": input_addressline1,
            "loc": input_locality,
            "adminarea": input_administrativearea,
            "postal": input_postal,
            "anyname": input_any_name
        }

        print("\n================================== INPUTS ==================================\n")
        print(f"\t   Base Service Url: {base_service_url}")
        print(f"\t  Service End Point: {service_endpoint}")
        print(f"\t        Max Records: {input_max_records}")
        print(f"\t        Match Level: {input_match_level}")
        print(f"\t       Addressline1: {input_addressline1}")
        print(f"\t           Locality: {input_locality}")
        print(f"\tAdministrative Area: {input_administrativearea}")
        print(f"\t             Postal: {input_postal}")
        print(f"\t           Any Name: {input_any_name}")

       # Create Service Call
        # Set the License String in the Request
        rest_request = f"&id={urllib.parse.quote_plus(license)}"

        # Set the Input Parameters
        for k, v in inputs.items():
            rest_request += f"&{k}={urllib.parse.quote_plus(v)}"

        # Build the final REST String Query
        rest_request = service_endpoint + f"?{rest_request}"

        # Submit to the Web Service.
        success = False
        retry_counter = 0

        while not success and retry_counter < 5:
            try: #retry just in case of network failure
                get_contents(base_service_url, rest_request)
                print()
                success = True
            except Exception as ex:
                retry_counter += 1
                print(ex)
                return

        is_valid = False;

        if (maxrecords is not None) and (matchlevel is not None) and (addressline1 is not None) and (locality is not None) and (administrativearea is not None) and (postal is not None) and (anyname is not None):
            inputline = maxrecords + matchlevel + addressline1 + locality + administrativearea + postal + anyname
        else:
            inputline = None

        if inputline is not None and inputline != "":
            is_valid = True
            should_continue_running = False

        while not is_valid:
            test_another_response = input("\nTest another record? (Y/N)")
            if test_another_response != '':
                test_another_response = test_another_response.lower()
                if test_another_response == 'y':
                    is_valid = True
                elif test_another_response == 'n':
                    is_valid = True
                    should_continue_running = False
                else:
                    print("Invalid Response, please respond 'Y' or 'N'")

    print("\n================== THANK YOU FOR USING MELISSA CLOUD API ===================\n")

main()
