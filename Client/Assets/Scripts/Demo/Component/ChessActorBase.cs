using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChessActorBase : ActorBase
{
    public MLabActorType targetType = MLabActorType.None;

    [Header("Movement Settings")]
    [SerializeField] private float moveSpeed = 5f;
    [SerializeField] private float rotationSpeed = 360f;
    [SerializeField] private float stopDistance = 0.1f;
    [SerializeField] private bool faceTarget = true;
    [SerializeField] private bool smoothMovement = true;

    [Header("Animation")]
    [SerializeField] private string movingAnimationTrigger = "IsMoving";

    private SpriteRenderer spriteRenderer;
    private Vector3 currentVelocity;
    private bool isMoving = false;


    public override void Awake()
    {
        base.Awake();
        spriteRenderer = GetComponent<SpriteRenderer>();
        targetTransform = GameMain.Instance.GetTransformTarget(targetType);
    }
 
    private void Update()
    {
        if (targetTransform == null) return;

        Vector3 directionToTarget = targetTransform.position - transform.position;
        float distanceToTarget = directionToTarget.magnitude;

        // Check attack condition using base class method
        bool attacked = IsAttackedThisFrame();

        // Move if not in attack range and not attacked this frame
        float stopDistance = Mathf.Max(this.stopDistance, weapons[0].attackRange);
        if (distanceToTarget > stopDistance  && !attacked)
        {
            Vector3 normalizedDirection = directionToTarget.normalized;

            if (smoothMovement)
            {
                transform.position = Vector3.SmoothDamp(
                    transform.position,
                    targetTransform.position,
                    ref currentVelocity,
                    0.3f,
                    moveSpeed
                );
            }
            else
            {
                transform.position += normalizedDirection * moveSpeed * GameMain.deltaTime;
            }

            if (faceTarget)
            {
                spriteRenderer.flipX = normalizedDirection.x < 0;
            }

            if (!isMoving)
            {
                isMoving = true;
                OnMovementStateChanged();
            }
        }
        else if (isMoving)
        {
            isMoving = false;
            OnMovementStateChanged();
        }

        CheckHealth();
    }

    private void OnMovementStateChanged()
    {
        if (useAnimation)
        {
            animator.SetBool(movingAnimationTrigger, isMoving);
        }
    }

    private void CheckHealth()
    {
        if (currentHealth <= 0)
        {
            ActorManager.Instance.RemoveActor(gameObject, actorType);
        }
    }
}