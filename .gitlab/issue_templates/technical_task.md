<!--
Name: Task
Description: Create a task.
Labels: Meta: Unknown Priority
-->

## ⚙️ Task

<!--
This form is for creating a specific, actionable task.
Tasks should be small enough to be completed by one person in a short amount of time.
-->

---

## 📋 Task Description & Context

<!--
Briefly describe what needs to be done and why.

Example:

Create the backend API endpoint for liking a video.
The endpoint will handle authentication, database updates, and return the correct response codes.
-->
…

---

## ✅ Subtasks

<!--
Break down the task into a checklist of specific, actionable subtasks.

Example:

- [ ] Create the POST /api/v1/video/{id}/like route and its controller function.
- [ ] Implement the LikeService logic to handle successful like/unlike operations, 404 (video not found), and 409 (already liked) responses.
- [ ] Apply JWT authentication middleware to the new like route to ensure it's protected.
- [ ] Write unit tests for LikeService covering all scenarios.
- [ ] Document the new endpoint in the OpenAPI/Swagger spec.
-->
- [ ] …

---

## ✅ Task Acceptance Criteria

<!--
List specific and verifiable outcomes.
This is what will be checked during review.

Example:

- [ ] A `POST` route is created at `/api/v1/video/{id}/like`.
- [ ] The route is protected and requires a valid JWT.
- [ ] A successful request returns a `200 OK` status.
- [ ] A request for a video the user has already liked returns a `409 Conflict`.
- [ ] A request with a non-existent `video_id` returns a `404 Not Found`.
- [ ] Unit tests for the `LikeService` are written and pass with >90% coverage.
- [ ] The new endpoint is documented in the OpenAPI/Swagger spec.
-->
- [ ] …

---

## 🔗 Sub-issues

_Sub-issues are blockers for this task._
