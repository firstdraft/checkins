# Checkins

## Setup

1.  Run `bin/setup`
2.  Run `rails dev:prime`

After starting the server, you can visit <localhost:3000/teacher> or <localhost:3000/student> to backdoor login as a teacher/student without launching from an LMS (e.g. Canvas).

## Domain Model

![Domain Model](erd.png?raw=true "Domain Model")

### Launching from an LMS

You can also launch into Checkins from firstdraft's [demo Canvas course](https://canvas.instructure.com/courses/1176838/) from the below assignments. You can sign in with demolearner11@firstdraft.com as a student or your own credentials as a teacher (if Raghu has invited you to the course). Contact Raghu or Logan if you need the demolearner11 password. Please do not edit the assignments.

Demo Canvas assignments:

- [Development](https://canvas.instructure.com/courses/1176838/assignments/10869713)
- [Staging](https://canvas.instructure.com/courses/1176838/assignments/10720909)
- [Production](https://canvas.instructure.com/courses/1176838/assignments/10505638)

If you'd like to test launching into a review app from Canvas, a new course app must be added and configured then a new assignment using that app must be created.

#### Creating a new app:

1.  From the [course page](https://canvas.instructure.com/courses/1176838/), click on **Settings** in the left-hand pane.
2.  Click on the **Apps** tab.
3.  Click "View App Configurations"
4.  Click "+ App" button
5.  From **Configuration Type** dropdown, select **By URL**.
6.  Enter a name for the App (e.g. firstdraft Checkins review app 34)
7.  Enter credentials (default credentials are "key" and "secret")
8.  Enter Config URL (e.g. <https://checkins-staging-pr-34.herokuapp.com/config.xml>)
9.  Click **Submit**

#### Adding a new assignment:

1.  From the [course page](https://canvas.instructure.com/courses/1176838/), click on **Assignments** in the left-hand pane.
2.  Click the "+ Assignment" button
3.  Fill in the Assignment Name (e.g. Checkins Review App 34)
4.  Fill in points (10 is a good value)
5.  In the **Submission Type** pane, select **External Tool** from the dropdown
6.  Click the **Find** button without entering any text
7.  Select the Checkins app you'd like to launch
8.  Check **Load This Tool In A New Tab**
9.  Click **Save & Publish**
