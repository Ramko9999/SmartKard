## SmartKard

Rohan, Ramki and Rahul's project for the Minnehack IO Hackathon.

## Inspiration
Communication and networking is one of the most important aspects in our life, education and the workplace. We always found it harder to perfect the exchange of information with each other. Moreover, many students lack business cards to distribute upon interactions, limiting their social interactions and preventing them from seizing opportunities.

## What it does
Our app uses QR code technology to seamlessly transfer contact information between two clients. With the QR code, we are able to extract information such as email, phone number and social media handles. Then this information used to create a contact of that person on the phone. Furthermore, we have implemented a prefix tree as well as an inbuilt UrlLauncher to open up apps natively.

## How we built it
We wanted to make it available on IOS and Android, so we decided to use the Flutter framework provided by google. We also used Firebase ML Vision for the QR Code Scanner, and used Figma to create intuitive UI.

## Challenges we ran into
First we tried to use NFC to transfer information between the two clients/devices, since we initially believed that NFC would produce the most efficient exchange of data. While, we were able to find ways to establish a connection, we were unable to send and read data. Furthermore, another challenge was with state management, since there are many components and pages in our flutter app that are linked with in each other. We decided to solve this problem with BLoC management. Finally, we also had the trouble of efficiently looking up contact names based on queries, similar to how google autocompletes names. To solve this, we used a prefix trie and loaded the contact names into it and had very fast searching.

## Accomplishments that we are proud of
Despite our initial fears of not being able to compete among other skilled competitors, we were able to provide solution to one of the most common

## What we learned
We learned a lot throughout the hackathon, including flutter, figma, and ML Kit.

## What's next for SmartKard
We are thrilled about SmartKard, and we want to continue developing this app to make it as efficient and intuitive as possible. Currently, we are using QR codes to share information; however, we want to enhance this feature by using NFC technology. Our vision is for people to use this tool at
