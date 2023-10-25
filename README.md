# InPost Recruitment Task

The main focus of the task was to address the following subtasks:

- Add grouping to the list of `Pack`s !!!
- Style as requested from the Design department ([Figma !!! link](https://www.figma.com/file/MzPR3whRl6KB1fFnkyM6Or/recruitment-task?node-id=0%3A1)):
    - Groups
    - App background
    - Fonts (typography and style)
    - Add image in the corner of the list cell
- Create unit tests !!!

All above tasks have been completed and you can find them in the code repository. 

During working on my solution I did introduce the following changes: 
- I reorganized the project structure
- I introduced a couple of optimizations: 
    - asking iOS to cache the rendered shadow
    - make all classes `final`
    - using `[weak self]` inside callbacks in order to avoid memory leaks


In addition, I did pick the following extra tasks:
- Fix one `Pack` appearing with unsupported status
    - I chose that one cause addressing unsupported statuses can help us to avoid many problems in the future e.g. crashes. 
    - I introduced `PackStatus` enumeration, which supports one extra state: `UNKNOWN`
    - I filter out all `Pack` with `UNKNOWN` state in order to not show them to the user
- Sort list items in groups by
    - I picked this one cause I think it's a matter of good UI/UX to have things sorted on the list in order to recognize them easier
    - I added an extension to the sequence of `Pack`s in order to make the code reusable
- Add pull to refresh and handle refresh progress 
    - This one gives user to ability to stay up-to-date

### Next steps

If I had more time I would consider the following
-  Stop using `xib`s or `storyboard` in favor of the views created by code - it's a more scalable approach
- Introduce `Dependency Injection` for all services e.g. `PackNetworking` - in order to make to code better testable
- Introduce `Localization`'s and keep all raw String in that manner in order to support multilaguality
