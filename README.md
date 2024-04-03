# README

This is my solution to the Job Match Recommendation Engine Challenge. 
I was able to get a working solution fairly quickly and spent most of my time optimising the matching process as well as the User experience.

There are two options when loading the csv data:
- Reload normal dataset: the provided .csv's
- Reload large dataset: loads 50 jobs and 100 jobseekers
Each time a load button is clicked, the controller will delete all existing records then redirect the User to a paginated table of all JobMatches sorted by jobseeker_id, matching_skill_percent and job_id

It seems certain that additional features or an even larger dataset would result in a longer load time. To counter that the find_match method should be moved to a job queue/background worker. 

Performance improvements (current _large performance is ~27s):
- not using find_or_create_by (-1s per instance)
- create a JobMatch only where there are matched skills, i.e. where seeker has at least one matching skill (-30s)
  I made an assumption here that it is not useful data to give information about what Jobseekers do not have any of the required skills.
- load Skills before find_match method (-9s)
- store matching_skill values on the JobMatch table (-5s)
- pagination (-9s)
  Assumption here on how the data would be viewed by the end User. I did not think it was appropriate to load all the records, match them together then show all JobMatches on one page. 

## Ruby version
3.1.2

## Project Setup
```bash
  $ bundle
  $ rake db:create
  $ rake db:migrate
  $ rails server
```
Using the following Gems:
- will_paginate: out of the box pagination option
- pry: for debugging
- rspec: unit tests
- rack-mini-profiler: provides speed badge on view

## How to run the test suite
```bash
  $ bundle exec rspec
```

## Progress Notes

Done:
- Jobs, Jobseekers, Skills tables
- joins table (JobMatches)
- polymorphic joins table (JobSkills)
- bulk create Jobs and Jobseekers method
- create a Skill if it does not exist then add to a Job/Jobseeker
- matching_skill_percent on JobMatches
- matching_skill_count on JobMatches
- sorting of Matches results (jobseeker_id ASC, matching_skill_percent DESC, job_id ASC)
- red/orange/yellow/green for percentiles
- css
- Efficiency: loop through and create all Jobs then iteratively create a Seeker then match them with all Jobs through Skills
- implement load time calc (rack-mini-profiler)
- pagination
- rspec tests
- allow regular/large data set loading

# Coding Challenge: Job Match Recommendation Engine

Your task is to develop a basic recommendation engine for a job-matching platform. The goal of the engine is to suggest jobs to jobseekers based on their skills and the required skills for each job.

You will be provided with two CSV files:

`jobseekers.csv`: This file contains information about jobseekers. Each row represents a jobseeker and has the following columns:

* `id`: A unique identifier for the jobseeker.
* `name`: The name of the jobseeker.
* `skills`: A comma-separated list of the jobseeker's skills.

`jobs.csv`: This file contains information about jobs. Each row represents a job and has the following columns:

* `id`: A unique identifier for the job.
* `title`: The title of the job.
* `required_skills`: A comma-separated list of skills required for the job.

You should write a program that reads these two CSV files and outputs a list of job recommendations for each jobseeker. Each recommendation should include the jobseeker's ID, the job ID, and the number of matching skills.

The output should be sorted first by jobseeker ID and then by the percentage of matching skills in descending order (so that jobs with the highest percentage of matching skills are listed first). If two jobs have the same matching skill percentage, they should be sorted by job ID in ascending order.

Here's an example of what the output might look like:

```
jobseeker_id, jobseeker_name, job_id, job_title, matching_skill_count, matching_skill_percent
1, Alice, 5, Ruby Developer, 3, 100
1, Alice, 2, .NET Developer, 3, 75
1, Alice, 7, C# Developer, 3, 75
1, Alice, 4, Dev Ops Engineer, 4, 50
2, Bob, 3, C++ Developer, 4, 100
2, Bob, 1, Go Developer, 3, 75
2, Bob, 1, Go Developer, 3, 75
2, Bob, 1, Go Developer, 3, 75
2, Bob, 1, Go Developer, 3, 75
2, Bob, 1, Go Developer, 3, 75
2, Bob, 1, Go Developer, 3, 75
...
```

Your solution should be written in the programming language of your choice. Please include instructions for how to run your program and any tests you have written.
Please open a repository (preferred) or email your zipped up code to the hiring manager when you have completed the test.

You will be evaluated on the following criteria:

* Correctness: Does your program correctly match jobseekers to jobs based on their skills?
* Code quality: Is your code easy to understand and maintain?
* Extendibility: If we needed to add additional functionality, how difficult would this be?
* Efficiency: How well does your program handle large inputs?
* Tests: Is your code covered by automated tests?
