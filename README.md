<section class="content">
        <article>
          <header>
            <h1>
              Relational Rails
              <small></small>
            </h1>
          </header>
          <h2 id="learning-goals">Learning Goals</h2>

<ul>
  <li>Design a one-to-many relationship using a schema designer.</li>
  <li>Write migrations to create tables with columns of varying data types and foreign keys.</li>
  <li>Use Rails to create web pages that allow users to CRUD resources.</li>
  <li>Create instance and class methods on a Rails model that use ActiveRecord methods and helpers.</li>
  <li>Write model and feature tests that fully cover data logic and user behavior.</li>
</ul>

<h2 id="requirements">Requirements</h2>

<ul>
  <li>must use Rails 5.2.x</li>
  <li>must use PostgreSQL</li>
  <li>must “handroll” all routes (no use of <code class="language-plaintext highlighter-rouge">resources</code> syntax)</li>
</ul>

<h2 id="permission">Permission</h2>

<ul>
  <li>If there is a specific gem you’d like to use in this project that is not mentioned on this project page, you must get permission from your instructors first.</li>
</ul>

<h2 id="setup">Setup</h2>
<p>Students should create their own new Rails app for this project. Students can reference the <a href="https://github.com/turingschool-examples/task_manager_rails">Task Manager tutorial app</a> for how to set up a new Rails project.</p>

<p>Students must host their code in a new repository on GitHub.</p>

<h2 id="evaluation">Evaluation</h2>
<p><a href="./peer_code_share">Peer code share</a>, evaluation, and rubric information can be found <a href="./evaluation">here</a>.</p>

<hr>

<h2 id="relationships">Relationships</h2>

<h3 id="design-your-database">Design your database</h3>

<p>Read <a href="https://backend.turing.edu/module2/lessons/one_to_many_relationships">this lesson plan</a> and use it as a reference when designing your database.</p>

<p>Each student will come up with their own one-to-many relationship. This should represent a real world example of your choice. An example would be:</p>
<ul>
  <li>Shelters and Pets</li>
  <li>A Shelter has many Pets</li>
  <li>A Pet belongs to one Shelter.</li>
</ul>

<p>Do not use “Parent”/”Child” as your relationship.</p>

<p>These relationships are yours to create, but instructors are happy to provide feedback on the relationships if asked.</p>

<p>Use <a href="https://www.dbdesigner.net/">This database design site</a> to design your database with your one-to-many relationships.</p>

<p>Here is an example diagram:</p>

<p><img src="/module2/misc/images/adopt_dont_shop_db_design.png" alt="Example Design"></p>

<p>You can create as many columns on each table as you would like, but we need a few columns represented on each table:</p>

<ol>
  <li>One string column for a ‘name’</li>
  <li>One boolean column</li>
  <li>One numeric column</li>
  <li>Two DateTime columns: <code class="language-plaintext highlighter-rouge">created_at</code> and <code class="language-plaintext highlighter-rouge">updated_at</code></li>
</ol>

<p>A couple of things to keep in mind as you’re designing your schema:</p>

<ul>
  <li>Foreign Keys do not count as an integer column.</li>
  <li>You should not create columns that duplicate data. For example, in Pets/Shelters, a Shelter should not store a “pet_count” column since the count of Pets can also be found by counting the number of associated pets.</li>
</ul>

<p><strong>Schema Design will be reviewed as part of our first check-in.</strong></p>

<hr>

<h2 id="user-stories">User Stories</h2>

<p>A user story is a concise description of functionality that a specific user should experience while using your application. In these stories, we will refer to the “one” side of the relationship as the “parent” and the “many” side of the relationship as the “children/child”. In the Pets/Shelters example, Shelter would be the parent, and Pets would be the children.</p>

<p>Children can be associated to the Parent. Children belong to a parent. Anywhere you see <code class="language-plaintext highlighter-rouge">child_table_name</code> think <code class="language-plaintext highlighter-rouge">pets</code> from our Pets and Shelters example.</p>

<p>Each user story will focus on one of the following:</p>

<ul>
  <li><strong>ActiveRecord</strong></li>
  <li><strong>CRUD Functionality</strong></li>
  <li><strong>Usability</strong>: Users should be able to use the site easily. This means making sure there are links/buttons to reach all parts of the site and the styling/layout is sensible.</li>
</ul>

<p><em>Note</em>: When writing code for each user story, it is important to go in numerical order; don’t jump around. You may notice some later user stories “overwriting” earlier stories - this is intentional and mimics what you may experience on the job when working with real clients.</p>

<h2 id="iteration-1">Iteration 1</h2>

<h5 id="crud">CRUD</h5>

<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>[ ] done

User Story 1, Parent Index 

For each parent table
As a visitor
When I visit '/parents'
Then I see the name of each parent record in the system
</code></pre></div></div>

<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>[ ] done

User Story 2, Parent Show 

As a visitor
When I visit '/parents/:id'
Then I see the parent with that id including the parent's attributes
(data from each column that is on the parent table)
</code></pre></div></div>

<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>[ ] done

User Story 3, Child Index 

As a visitor
When I visit '/child_table_name'
Then I see each Child in the system including the Child's attributes
(data from each column that is on the child table)
</code></pre></div></div>

<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>[ ] done

User Story 4, Child Show 

As a visitor
When I visit '/child_table_name/:id'
Then I see the child with that id including the child's attributes
(data from each column that is on the child table)
</code></pre></div></div>

<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>[ ] done

User Story 5, Parent Children Index 

As a visitor
When I visit '/parents/:parent_id/child_table_name'
Then I see each Child that is associated with that Parent with each Child's attributes
(data from each column that is on the child table)
</code></pre></div></div>

<h5 id="activerecord">ActiveRecord</h5>

<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>[ ] done

User Story 6, Parent Index sorted by Most Recently Created 

As a visitor
When I visit the parent index,
I see that records are ordered by most recently created first
And next to each of the records I see when it was created
</code></pre></div></div>

<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>[ ] done

User Story 7, Parent Child Count

As a visitor
When I visit a parent's show page
I see a count of the number of children associated with this parent
</code></pre></div></div>

<h5 id="usability">Usability</h5>

<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>[ ] done

User Story 8, Child Index Link

As a visitor
When I visit any page on the site
Then I see a link at the top of the page that takes me to the Child Index
</code></pre></div></div>

<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>[ ] done

User Story 9, Parent Index Link

As a visitor
When I visit any page on the site
Then I see a link at the top of the page that takes me to the Parent Index
</code></pre></div></div>

<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>[ ] done

User Story 10, Parent Child Index Link

As a visitor
When I visit a parent show page ('/parents/:id')
Then I see a link to take me to that parent's `child_table_name` page ('/parents/:id/child_table_name')
</code></pre></div></div>

<p><strong>Iteration 1 will be reviewed at your second check-in</strong></p>

<hr>

<h2 id="iteration-2">Iteration 2</h2>

<h5 id="crud-1">CRUD</h5>

<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>[ ] done

User Story 11, Parent Creation 

As a visitor
When I visit the Parent Index page
Then I see a link to create a new Parent record, "New Parent"
When I click this link
Then I am taken to '/parents/new' where I  see a form for a new parent record
When I fill out the form with a new parent's attributes:
And I click the button "Create Parent" to submit the form
Then a `POST` request is sent to the '/parents' route,
a new parent record is created,
and I am redirected to the Parent Index page where I see the new Parent displayed.
</code></pre></div></div>

<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>[ ] done

User Story 12, Parent Update 

As a visitor
When I visit a parent show page
Then I see a link to update the parent "Update Parent"
When I click the link "Update Parent"
Then I am taken to '/parents/:id/edit' where I  see a form to edit the parent's attributes:
When I fill out the form with updated information
And I click the button to submit the form
Then a `PATCH` request is sent to '/parents/:id',
the parent's info is updated,
and I am redirected to the Parent's Show page where I see the parent's updated info
</code></pre></div></div>

<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>[ ] done

User Story 13, Parent Child Creation 

As a visitor
When I visit a Parent Children Index page
Then I see a link to add a new adoptable child for that parent "Create Child"
When I click the link
I am taken to '/parents/:parent_id/child_table_name/new' where I see a form to add a new adoptable child
When I fill in the form with the child's attributes:
And I click the button "Create Child"
Then a `POST` request is sent to '/parents/:parent_id/child_table_name',
a new child object/row is created for that parent,
and I am redirected to the Parent Childs Index page where I can see the new child listed
</code></pre></div></div>

<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>[ ] done

User Story 14, Child Update 

As a visitor
When I visit a Child Show page
Then I see a link to update that Child "Update Child"
When I click the link
I am taken to '/child_table_name/:id/edit' where I see a form to edit the child's attributes:
When I click the button to submit the form "Update Child"
Then a `PATCH` request is sent to '/child_table_name/:id',
the child's data is updated,
and I am redirected to the Child Show page where I see the Child's updated information
</code></pre></div></div>

<h5 id="activerecord-1">ActiveRecord</h5>

<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>[ ] done

User Story 15, Child Index only shows `true` Records 

As a visitor
When I visit the child index
Then I only see records where the boolean column is `true`
</code></pre></div></div>

<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>[ ] done

User Story 16, Sort Parent's Children in Alphabetical Order by name 

As a visitor
When I visit the Parent's children Index Page
Then I see a link to sort children in alphabetical order
When I click on the link
I'm taken back to the Parent's children Index Page where I see all of the parent's children in alphabetical order
</code></pre></div></div>

<h5 id="usability-1">Usability</h5>

<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>[ ] done

User Story 17, Parent Update From Parent Index Page 

As a visitor
When I visit the parent index page
Next to every parent, I see a link to edit that parent's info
When I click the link
I should be taken to that parent's edit page where I can update its information just like in User Story 12
</code></pre></div></div>

<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>[ ] done

User Story 18, Child Update From Childs Index Page 

As a visitor
When I visit the `child_table_name` index page or a parent `child_table_name` index page
Next to every child, I see a link to edit that child's info
When I click the link
I should be taken to that `child_table_name` edit page where I can update its information just like in User Story 14
</code></pre></div></div>

<hr>

<h2 id="iteration-3">Iteration 3</h2>

<h5 id="crud-2">CRUD</h5>

<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>[ ] done

User Story 19, Parent Delete 

As a visitor
When I visit a parent show page
Then I see a link to delete the parent
When I click the link "Delete Parent"
Then a 'DELETE' request is sent to '/parents/:id',
the parent is deleted, and all child records are deleted
and I am redirected to the parent index page where I no longer see this parent
</code></pre></div></div>

<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>[ ] done

User Story 20, Child Delete 

As a visitor
When I visit a child show page
Then I see a link to delete the child "Delete Child"
When I click the link
Then a 'DELETE' request is sent to '/child_table_name/:id',
the child is deleted,
and I am redirected to the child index page where I no longer see this child
</code></pre></div></div>

<h5 id="activerecord-2">ActiveRecord</h5>

<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>[ ] done

User Story 21, Display Records Over a Given Threshold 

As a visitor
When I visit the Parent's children Index Page
I see a form that allows me to input a number value
When I input a number value and click the submit button that reads 'Only return records with more than `number` of `column_name`'
Then I am brought back to the current index page with only the records that meet that threshold shown.
</code></pre></div></div>

<h5 id="usability-2">Usability</h5>

<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>[ ] done

User Story 22, Parent Delete From Parent Index Page 

As a visitor
When I visit the parent index page
Next to every parent, I see a link to delete that parent
When I click the link
I am returned to the Parent Index Page where I no longer see that parent
</code></pre></div></div>

<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>[ ] done

User Story 23, Child Delete From Childs Index Page 

As a visitor
When I visit the `child_table_name` index page or a parent `child_table_name` index page
Next to every child, I see a link to delete that child
When I click the link
I should be taken to the `child_table_name` index page where I no longer see that child
</code></pre></div></div>
<hr>

<h2 id="extensions">Extensions</h2>

<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>[ ] done

Extension 1: Sort Parents by Number of Children 

As a visitor
When I visit the Parents Index Page
Then I see a link to sort parents by the number of `child_table_name` they have
When I click on the link
I'm taken back to the Parent Index Page where I see all of the parents in order of their count of `child_table_name` (highest to lowest) And, I see the number of children next to each parent name
</code></pre></div></div>

<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>[ ] done

Extension 2: Search by name (exact match)

As a visitor
When I visit an index page ('/parents') or ('/child_table_name')
Then I see a text box to filter results by keyword
When I type in a keyword that is an exact match of one or more of my records and press the Search button
Then I only see records that are an exact match returned on the page
</code></pre></div></div>

<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>[ ] done

Extension 3: Search by name (partial match)

As a visitor
When I visit an index page ('/parents') or ('/child_table_name')
Then I see a text box to filter results by keyword
When I type in a keyword that is an partial match of one or more of my records and press the Search button
Then I only see records that are an partial match returned on the page

This functionality should be separate from your exact match functionality.
</code></pre></div></div>

        </article>
        
      </section>
