# MealGenerator
## Overview

This is a prototype of an iOS Application that uses GPT api to generate random recipes based on the
inputs given by the user.
The aim of this app is to simplify prompt generation by giving the user predefined categories and
an easy to use UI.
Currently the app is set up to only generate german prompts and recipes.

## Installation
### GTP api
To simplify the GPT connection the code uses a library that is provided by FuturraGroup:
https://github.com/FuturraGroup/OpenAI
Instructions for setting up the gpt api are given by the authors.

### Swift Package Manager
Besides the OpenAI package, the app depends on the custom MealGeneratorKit package.
Packages can be set up in the Package Dependencies in XCode in the project settings.
The MealGeneratorKit provides the Recipe class.

## Usage
Since the api key needs to be private, a key.txt that contains the gpt api key has to created inside the project folder.
After that simply run the code in either simulation or an iPhone that has iOS 17.0 + installed.

### Functionality
Currently only Generation is supported, but in future recipes can be saved and additional functionality will be added.

### Meal Generation UI
To keep things simple, the user can choose from different attributes between different categroies which are:

Meal type (swipe to the right or left to change tap to select): 

![IMG_65FB08CF892A-1](https://github.com/PhilT97/MealGenerator/assets/116505621/56beea03-9f78-4f57-82e2-79141baec809)

Meal Time (swipe down or up and tap to select):

![IMG_75C5170A8955-1](https://github.com/PhilT97/MealGenerator/assets/116505621/97880fa9-c3f6-4e7d-8493-e25a564ef2ee)

Meal Region (choose either on the picker or the world map, currently only supports german translation):

![IMG_2FB36B3CA70F-1](https://github.com/PhilT97/MealGenerator/assets/116505621/e694d131-61a7-4c72-bb79-77b0ac78e9c6)

Custom inputs:

Define ingredients or kitchen utils that can be either added (+) to the recipe or the recipe should not contain (-)

![IMG_5ACB25A36FCA-1](https://github.com/PhilT97/MealGenerator/assets/116505621/3d137302-719b-4e92-90ff-8127c7e96cfa)

Meal Generation:

The user will be asked about the set of prompts given and gpt generates a recipe based on the given prompts:

![IMG_B293C5CA5B99-1](https://github.com/PhilT97/MealGenerator/assets/116505621/a2e2e44a-c1d9-413a-95dc-d5b059ef7e4b)
![IMG_D15B5C4313B1-1](https://github.com/PhilT97/MealGenerator/assets/116505621/345e8bb8-1116-46a5-960c-4e0ab4951a11)

## Future Work
Since this is a wip prototype there are still functions missing like:
- Library containing user defined 'CookBooks' where recipes can be saved
- a shopping cart where recipe ingredients can be saved
- a Main Screen with the option to generate a recipe for a given Prompt (like Recipe for: Banana cake)
- see issues for more





